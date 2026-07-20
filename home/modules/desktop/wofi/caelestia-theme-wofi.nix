{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "caelestia-theme-wofi";
      runtimeInputs = [
        config.programs.caelestia.package
        pkgs.coreutils
        pkgs.gawk
        pkgs.gnused
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
        wofi_output=""

        cleanup() {
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

        run_wofi() {
          local input_file="$1"
          shift
          local output_file

          output_file="$(mktemp)"
          temp_files+=("$output_file")

          if ! wofi "$@" < "$input_file" > "$output_file"; then
            wofi_output=""
            return 0
          fi

          wofi_output="$(cat "$output_file")"
        }

        display_command() {
          local map_file="$1"
          printf "awk -F '\\t' -v key='%%s' '\$1 == key { print \$2; exit }' '%s'" "$map_file"
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
        current_mode="''${current_scheme[2]:-dark}"
        current_variant="''${current_scheme[3]:-tonalspot}"

        case "$current_mode" in
          light) mode_icon="" ;;
          *) mode_icon="" ;;
        esac
        palette_icon=""

        caelestia_bin="$(readlink -f "$(command -v caelestia)")"
        caelestia_root="''${caelestia_bin%/bin/caelestia}"
        scheme_data_dir=""
        for candidate in "$caelestia_root"/lib/python*/site-packages/caelestia/data/schemes; do
          if [ -d "$candidate" ]; then
            scheme_data_dir="$candidate"
            break
          fi
        done

        supports_mode() {
          local name="$1"
          local flavour="$2"
          local mode="$3"

          if [ "$name" = "dynamic" ]; then
            return 0
          fi

          [ -n "$scheme_data_dir" ] && [ -f "$scheme_data_dir/$name/$flavour/$mode.txt" ]
        }

        pretty_words() {
          local value="''${1//[-_]/ }"
          local word
          local output=""

          for word in $value; do
            output+="''${output:+ }''${word^}"
          done

          printf "%s" "$output"
        }

        variant_label() {
          case "$1" in
            tonalspot) printf "Tonal Spot" ;;
            fruitsalad) printf "Fruit Salad" ;;
            *) pretty_words "$1" ;;
          esac
        }

        declare -A flavour_counts=()
        while IFS=$'\t' read -r name flavour; do
          [ -n "$name" ] && [ -n "$flavour" ] || continue
          flavour_counts["$name"]="$(( ''${flavour_counts["$name"]:-0} + 1 ))"
        done < "$schemes_cache"

        scheme_label() {
          local name="$1"
          local flavour="$2"
          local name_label
          local flavour_label

          name_label="$(pretty_words "$name")"

          if [ "$flavour" = "default" ] || [ "''${flavour_counts["$name"]:-1}" -eq 1 ]; then
            printf "%s" "$name_label"
            return
          fi

          flavour_label="$(pretty_words "$flavour")"
          printf "%s  ·  %s" "$name_label" "$flavour_label"
        }

        restart_portals() {
          systemctl --user try-restart \
            xdg-desktop-portal-gtk.service \
            xdg-desktop-portal-hyprland.service || true
        }

        apply_scheme() {
          caelestia scheme set \
            --notify \
            --name "$1" \
            --flavour "$2" \
            --mode "$3" \
            --variant "$4"

          restart_portals
        }

        menu_file="$(mktemp)"
        menu_display_file="$(mktemp)"
        temp_files+=("$menu_file" "$menu_display_file")

        printf "action:mode\n" >> "$menu_file"
        printf "action:mode\t%s  Mode       %s\n" "$mode_icon" "$(pretty_words "$current_mode")" >> "$menu_display_file"
        printf "action:palette\n" >> "$menu_file"
        printf "action:palette\t%s  Palette    %s\n" "$palette_icon" "$(variant_label "$current_variant")" >> "$menu_display_file"

        current_key=""
        current_display=""
        while IFS=$'\t' read -r name flavour; do
          [ -n "$name" ] && [ -n "$flavour" ] || continue
          supports_mode "$name" "$flavour" "$current_mode" || continue

          key="theme:$name:$flavour"
          label="$(scheme_label "$name" "$flavour")"
          if [ "$name" = "$current_name" ] && [ "$flavour" = "$current_flavour" ]; then
            current_key="$key"
            current_display="●  $label"
          else
            printf "%s\n" "$key" >> "$menu_file"
            printf "%s\t   %s\n" "$key" "$label" >> "$menu_display_file"
          fi
        done < "$schemes_cache"

        if [ -n "$current_key" ]; then
          rest_file="$(mktemp)"
          temp_files+=("$rest_file")
          cp "$menu_file" "$rest_file"
          {
            sed -n '1,2p' "$rest_file"
            printf "%s\n" "$current_key"
            sed -n '3,$p' "$rest_file"
          } > "$menu_file"
          printf "%s\t%s\n" "$current_key" "$current_display" >> "$menu_display_file"
        fi

        run_wofi "$menu_file" \
          --normal-window \
          --dmenu \
          --no-custom-entry \
          --cache-file=/dev/null \
          --style="$style_file" \
          --pre-display-cmd="$(display_command "$menu_display_file")" \
          --prompt="Theme · $(pretty_words "$current_mode") · $(variant_label "$current_variant")" \
          -Dline_wrap=word_char \
          -Dcontent_halign=fill \
          -Dvalign=center \
          -Ddynamic_lines=false \
          --lines=10 \
          --width=440 \
          --height=620
        choice="$wofi_output"

        [ -z "$choice" ] && exit 1

        if [ "$choice" = "action:mode" ]; then
          mode_file="$(mktemp)"
          mode_display_file="$(mktemp)"
          temp_files+=("$mode_file" "$mode_display_file")

          for mode in dark light; do
            key="mode:$mode"
            case "$mode" in
              light) option_icon="" ;;
              *) option_icon="" ;;
            esac
            printf "%s\n" "$key" >> "$mode_file"
            if [ "$mode" = "$current_mode" ]; then
              printf "%s\t●  %s  %s\n" "$key" "$option_icon" "$(pretty_words "$mode")" >> "$mode_display_file"
            else
              printf "%s\t   %s  %s\n" "$key" "$option_icon" "$(pretty_words "$mode")" >> "$mode_display_file"
            fi
          done

          run_wofi "$mode_file" \
            --normal-window \
            --dmenu \
            --no-custom-entry \
            --cache-file=/dev/null \
            --style="$style_file" \
            --pre-display-cmd="$(display_command "$mode_display_file")" \
            --prompt="Mode" \
            -Dcontent_halign=fill \
            -Dvalign=center \
            -Ddynamic_lines=false \
            --lines=2 \
            --width=440 \
            --height=240
          mode_choice="$wofi_output"

          [ -z "$mode_choice" ] && exit 1
          selected_mode="''${mode_choice#mode:}"

          [ "$selected_mode" = "$current_mode" ] && exit 0

          if ! supports_mode "$current_name" "$current_flavour" "$selected_mode"; then
            compatible_file="$(mktemp)"
            compatible_display_file="$(mktemp)"
            temp_files+=("$compatible_file" "$compatible_display_file")

            while IFS=$'\t' read -r candidate_name candidate_flavour; do
              [ -n "$candidate_name" ] && [ -n "$candidate_flavour" ] || continue
              supports_mode "$candidate_name" "$candidate_flavour" "$selected_mode" || continue
              key="theme:$candidate_name:$candidate_flavour"
              printf "%s\n" "$key" >> "$compatible_file"
              printf "%s\t%s\n" "$key" "$(scheme_label "$candidate_name" "$candidate_flavour")" >> "$compatible_display_file"
            done < "$schemes_cache"

            run_wofi "$compatible_file" \
              --normal-window \
              --dmenu \
              --no-custom-entry \
              --cache-file=/dev/null \
              --style="$style_file" \
              --pre-display-cmd="$(display_command "$compatible_display_file")" \
              --prompt="$(pretty_words "$selected_mode") themes" \
              -Dline_wrap=word_char \
              -Dcontent_halign=fill \
              -Dvalign=center \
              -Ddynamic_lines=false \
              --lines=10 \
              --width=440 \
              --height=620
            compatible_choice="$wofi_output"

            [ -z "$compatible_choice" ] && exit 1
            compatible_key="''${compatible_choice#theme:}"
            compatible_name="''${compatible_key%%:*}"
            compatible_flavour="''${compatible_key#*:}"

            [ -n "$compatible_name" ] && [ -n "$compatible_flavour" ] || exit 1
            apply_scheme "$compatible_name" "$compatible_flavour" "$selected_mode" "$current_variant"
            exit 0
          fi

          apply_scheme "$current_name" "$current_flavour" "$selected_mode" "$current_variant"
          exit 0
        fi

        if [ "$choice" = "action:palette" ]; then
          variant_file="$(mktemp)"
          variant_display_file="$(mktemp)"
          temp_files+=("$variant_file" "$variant_display_file")
          variant_count=0

          while IFS= read -r variant; do
            [ -n "$variant" ] || continue
            variant_count="$((variant_count + 1))"
            key="variant:$variant"
            label="$(variant_label "$variant")"
            printf "%s\n" "$key" >> "$variant_file"
            if [ "$variant" = "$current_variant" ]; then
              printf "%s\t●  %s\n" "$key" "$label" >> "$variant_display_file"
            else
              printf "%s\t   %s\n" "$key" "$label" >> "$variant_display_file"
            fi
          done < <(caelestia scheme list -v)

          variant_lines="$variant_count"
          [ "$variant_lines" -gt 10 ] && variant_lines=10
          variant_height="$((160 + variant_lines * 44))"

          run_wofi "$variant_file" \
            --normal-window \
            --dmenu \
            --no-custom-entry \
            --cache-file=/dev/null \
            --style="$style_file" \
            --pre-display-cmd="$(display_command "$variant_display_file")" \
            --prompt="Palette" \
            -Dcontent_halign=fill \
            -Dvalign=center \
            -Ddynamic_lines=false \
            --lines="$variant_lines" \
            --width=440 \
            --height="$variant_height"
          variant_choice="$wofi_output"

          [ -z "$variant_choice" ] && exit 1
          selected_variant="''${variant_choice#variant:}"

          [ -n "$selected_variant" ] || exit 1
          [ "$selected_variant" = "$current_variant" ] && exit 0
          apply_scheme "$current_name" "$current_flavour" "$current_mode" "$selected_variant"
          exit 0
        fi

        theme_key="''${choice#theme:}"
        name="''${theme_key%%:*}"
        flavour="''${theme_key#*:}"

        [ -n "$name" ] && [ -n "$flavour" ] || exit 1
        [ "$name" = "$current_name" ] && [ "$flavour" = "$current_flavour" ] && exit 0

        apply_scheme "$name" "$flavour" "$current_mode" "$current_variant"
      '';
    })
  ];
}
