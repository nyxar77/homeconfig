{pkgs, ...}: {
  home.packages = [
    (
      pkgs.writeShellApplication {
        name = "cliphist-wofi-img";
        runtimeInputs = with pkgs; [
          cliphist
          coreutils
          gawk
          hyprland
          imagemagick
          jq
          wl-clipboard
          wofi
        ];
        text = ''
          thumb_dir="''${XDG_CACHE_HOME:-$HOME/.cache}/cliphist/thumbs"
          entry_limit="''${CLIPHIST_WOFI_LIMIT:-30}"
          clear_label="x  Clear history"
          mkdir -p "$thumb_dir"

          runtime_dir="''${XDG_RUNTIME_DIR:-/tmp}"
          pid_file="$runtime_dir/cliphist-wofi-img.pid"

          if old_pid="$(cat "$pid_file" 2>/dev/null)" && [ -n "$old_pid" ] && [ "$old_pid" != "$$" ]; then
            if kill -0 "$old_pid" 2>/dev/null; then
              kill "$old_pid" 2>/dev/null || true
              sleep 0.05
            fi
          fi

          printf "%s\n" "$$" > "$pid_file"

          temp_files=()
          wofi_pid=""
          focus_watcher_pid=""
          wofi_output=""

          cleanup() {
            if [ -n "$focus_watcher_pid" ]; then
              kill "$focus_watcher_pid" 2>/dev/null || true
            fi
            if [ -n "$wofi_pid" ]; then
              kill "$wofi_pid" 2>/dev/null || true
            fi
            for file in "''${temp_files[@]}"; do
              rm -f "$file"
            done
            if [ "$(cat "$pid_file" 2>/dev/null || true)" = "$$" ]; then
              rm -f "$pid_file"
            fi
          }

          trap cleanup EXIT
          trap 'exit 130' INT
          trap 'exit 143' TERM

          watch_focus() {
            local target_pid="$1"
            local active_pid=""
            local focused=0

            for _ in $(seq 1 30); do
              kill -0 "$target_pid" 2>/dev/null || return 0
              active_pid="$(hyprctl activewindow -j 2>/dev/null | jq -r '.pid // empty' 2>/dev/null || true)"
              if [ "$active_pid" = "$target_pid" ]; then
                focused=1
                break
              fi
              sleep 0.05
            done

            [ "$focused" = 1 ] || return 0

            while kill -0 "$target_pid" 2>/dev/null; do
              active_pid="$(hyprctl activewindow -j 2>/dev/null | jq -r '.pid // empty' 2>/dev/null || true)"
              if [ -n "$active_pid" ] && [ "$active_pid" != "$target_pid" ]; then
                kill "$target_pid" 2>/dev/null || true
                return 0
              fi
              sleep 0.1
            done
          }

          run_wofi() {
            local input_file="$1"
            shift
            local output_file
            local status

            output_file="$(mktemp)"
            temp_files+=("$output_file")

            wofi "$@" < "$input_file" > "$output_file" &
            wofi_pid="$!"
            watch_focus "$wofi_pid" &
            focus_watcher_pid="$!"

            wait "$wofi_pid"
            status="$?"

            kill "$focus_watcher_pid" 2>/dev/null || true
            focus_watcher_pid=""
            wofi_pid=""

            wofi_output="$(cat "$output_file")"
            return "$status"
          }

          case "$entry_limit" in
            ""|*[!0-9]*) entry_limit=30 ;;
          esac

          set +o pipefail
          cliphist_list="$(cliphist list | head -n "$entry_limit")"
          set -o pipefail

          read -r -d ''' prog <<AWK || true
          function preview(text) {
            gsub(/\r/, "", text)
            gsub(/\t+/, " ", text)
            gsub(/[[:cntrl:]]+/, " ", text)
            gsub(/[[:space:]][[:space:]]+/, " ", text)
            gsub(/^[[:space:]]+|[[:space:]]+$/, "", text)
            if (text == "") {
              text = "empty clipboard item"
            }
            if (length(text) > 96) {
              text = substr(text, 1, 93) "..."
            }
            return text
          }

          /^[0-9]+\s<meta http-equiv=/ { next }

          match(\$0, /^([0-9]+)\s(\[\[\s)?binary.*(jpg|jpeg|png|bmp)/, grp) {
            image = grp[1] "." grp[3]
            system("[ -f $thumb_dir/" image " ] || printf " grp[1] "\\t | cliphist decode | magick - -resize '420x420>' $thumb_dir/" image)
            print "img:$thumb_dir/" image
            next
          }

          match(\$0, /^([0-9]+)[[:space:]]+(.*)$/, grp) {
            print grp[1] "\t" preview(grp[2])
            next
          }

          1
          AWK

          menu_file="$(mktemp)"
          temp_files+=("$menu_file")
          {
            printf "%s\n" "$clear_label"
            gawk <<< "$cliphist_list" "$prog"
          } > "$menu_file"

          run_wofi "$menu_file" \
            -I \
            --normal-window \
            --dmenu \
            --cache-file=/dev/null \
            --style="$HOME/.config/wofi/clipboard.css" \
            --prompt="Clipboard" \
            -Dline_wrap=word_char \
            -Dcontent_halign=fill \
            -Dimage_size=140 \
            -Dynamic_lines=true \
            --lines=5 \
            --width=500 \
            --height=500
          choice="$wofi_output"

          [ -z "$choice" ] && exit 1

          if [ "$choice" = "$clear_label" ]; then
            confirm_file="$(mktemp)"
            temp_files+=("$confirm_file")
            printf "Cancel\nClear history\n" > "$confirm_file"

            run_wofi "$confirm_file" \
              --normal-window \
              --dmenu \
              --cache-file=/dev/null \
              --style="$HOME/.config/wofi/clipboard.css" \
              --prompt="Clear clipboard history?" \
              --lines=2 \
              --width=420 \
              --height=160
            confirm="$wofi_output"
            [ "$confirm" = "Clear history" ] && cliphist wipe
            exit 0
          fi

          if [ "''${choice::4}" = "img:" ]; then
            thumb_file="''${choice:4}"
            clip_id="''${thumb_file##*/}"
            clip_id="''${clip_id%.*}"$'\t'
          else
            clip_id="$choice"
          fi

          printf "%s" "$clip_id" | cliphist decode | wl-copy
        '';
      }
    )
  ];

  # theme
  xdg.configFile.".caelestia/templates/clipboard.css".text = ''
    @define-color bg #282433;
    @define-color bg-deep #211e2a;
    @define-color surface #2c2737;
    @define-color surface-soft #352f43;
    @define-color surface-bright #3f3a50;
    @define-color text #eee9fc;
    @define-color muted #8a829e;
    @define-color accent #e965a5;
    @define-color blue #b1baf4;

    * {
      font-family: "JetBrainsMono Nerd Font", "JetBrains Mono", monospace;
      font-size: 13px;
      outline: none;
    }

    window {
      margin: 0;
      border: 1px solid @surface-bright;
      border-radius: 10px;
      background-color: @bg;
      box-shadow: 0 16px 44px rgba(0, 0, 0, 0.42);
    }

    #outer-box {
      padding: 14px;
      background-color: transparent;
    }

    #input {
      min-height: 42px;
      margin: 0 0 12px;
      padding: 0 12px;
      border: 1px solid @surface-bright;
      border-radius: 8px;
      color: @text;
      background-color: @bg-deep;
      caret-color: @accent;
      box-shadow: inset 0 0 0 1px rgba(233, 101, 165, 0.06), 0 6px 18px rgba(33, 30, 42, 0.26);
    }

    #input:focus {
      border-color: @accent;
      box-shadow: inset 0 0 0 1px rgba(233, 101, 165, 0.22), 0 6px 18px rgba(33, 30, 42, 0.26);
    }

    #scroll {
      margin: 0;
      border: none;
      background-color: transparent;
    }

    #inner-box {
      padding: 1px;
      color: @text;
      background-color: transparent;
    }

    #entry {
      min-height: 38px;
      margin: 0 0 5px;
      padding: 5px 9px;
      border: 1px solid transparent;
      border-left: 3px solid transparent;
      border-radius: 8px;
      color: @text;
      background-color: rgba(44, 39, 55, 0.42);
    }

    #entry:hover {
      border-color: @surface-bright;
      border-left-color: @blue;
      background-color: @surface-soft;
    }

    #entry:selected {
      border-color: rgba(233, 101, 165, 0.66);
      border-left-color: @accent;
      color: @text;
      background-color: rgba(233, 101, 165, 0.18);
      box-shadow: inset 0 0 0 1px rgba(233, 101, 165, 0.12);
    }

    #entry:selected #text {
      color: @text;
    }

    #text {
      margin: 0 8px;
      color: @text;
    }

    image {
      margin: 2px 10px 2px 0;
      padding: 3px;
      border: 1px solid @surface-bright;
      border-radius: 8px;
      background-color: @bg-deep;
      box-shadow: 0 4px 14px rgba(33, 30, 42, 0.24);
    }

    scrollbar {
      border: none;
      background-color: transparent;
    }

    scrollbar slider {
      min-width: 5px;
      min-height: 28px;
      border-radius: 999px;
      background-color: @surface-bright;
    }

    scrollbar slider:hover {
      background-color: @accent;
    }
  '';
}
