{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    (
      pkgs.writeShellApplication {
        name = "caelestia-theme-wofi";
        runtimeInputs = [
          config.programs.caelestia.package
          pkgs.coreutils
          pkgs.hyprland
          pkgs.jq
          pkgs.systemd
          pkgs.wofi
        ];
        text = ''
          style_file="''${XDG_STATE_HOME:-$HOME/.local/state}/caelestia/theme/clipboard.css"
          cache_dir="''${XDG_CACHE_HOME:-$HOME/.cache}/caelestia-theme-wofi"
          schemes_cache="$cache_dir/schemes.tsv"
          runtime_dir="''${XDG_RUNTIME_DIR:-/tmp}"
          pid_file="$runtime_dir/caelestia-theme-wofi.pid"

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

          mkdir -p "$cache_dir"

          if [ "''${1:-}" = "--refresh" ]; then
            rm -f "$schemes_cache"
          fi

          if [ ! -s "$schemes_cache" ]; then
            caelestia scheme list \
              | jq -r '
                  to_entries[]
                  | .key as $name
                  | .value
                  | keys[]
                  | "\($name)\t\(.)"
                ' \
              | sort > "$schemes_cache"
          fi

          mapfile -t current_scheme < <(caelestia scheme get -n -f -m -v)
          current_name="''${current_scheme[0]:-}"
          current_flavour="''${current_scheme[1]:-}"
          current_variant="''${current_scheme[3]:-tonalspot}"

          menu_file="$(mktemp)"
          temp_files+=("$menu_file")

          current_label=""
          while IFS=$'\t' read -r name flavour; do
            [ -n "$name" ] && [ -n "$flavour" ] || continue

            if [ "$name" = "$current_name" ] && [ "$flavour" = "$current_flavour" ]; then
              current_label="●  $name / $flavour"
            else
              printf "   %s / %s\n" "$name" "$flavour" >> "$menu_file"
            fi
          done < "$schemes_cache"

          if [ -n "$current_label" ]; then
            rest_file="$(mktemp)"
            temp_files+=("$rest_file")
            cp "$menu_file" "$rest_file"
            {
              printf "%s\n" "$current_label"
              cat "$rest_file"
            } > "$menu_file"
          fi

          run_wofi "$menu_file" \
            --normal-window \
            --dmenu \
            --cache-file=/dev/null \
            --style="$style_file" \
            --prompt="Theme" \
            -Dline_wrap=word_char \
            -Dcontent_halign=fill \
            -Dynamic_lines=true \
            --lines=8 \
            --width=500 \
            --height=500
          choice="$wofi_output"

          [ -z "$choice" ] && exit 1

          choice="''${choice#●  }"
          choice="''${choice#   }"
          name="''${choice%% / *}"
          flavour="''${choice#* / }"

          [ -n "$name" ] && [ -n "$flavour" ] || exit 1

          caelestia scheme set \
            --name "$name" \
            --flavour "$flavour" \
            --variant "$current_variant"

          systemctl --user daemon-reload || true
          systemctl --user restart \
            xdg-desktop-portal.service \
            xdg-desktop-portal-gtk.service \
            xdg-desktop-portal-hyprland.service || true
        '';
      }
    )
  ];
}
