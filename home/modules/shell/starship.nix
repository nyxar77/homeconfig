{...}: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      command_timeout = 90;
      scan_timeout = 30;
      format = "$character$nix_shell$c$cpp$bun$nodejs$lua$golang$rust$php\n$username$hostname$directory";
      # format = "$character$nix_shell$nodejs$lua$golang$rust$php$git_branch$git_commit$git_state$git_status\n$username$hostname$directory";
      character = {
        vicmd_symbol = "[](bold dimmed #ff79c6) ";
        vimcmd_replace_symbol = "[](bold dimmed purple) ";
        vimcmd_replace_one_symbol = "[](bold dimmed cyan) ";
        vimcmd_visual_symbol = "[](bold dimmed yellow) ";
        success_symbol = "[](bold green) ";
        error_symbol = "[✗](bold red) ";
      };

      /*
      git_branch = {
        symbol = " ";
        style = "#fc937b";
        format = "[$symbol$branch(:$remote_branch)]($style) ";
      };
      git_commit = {
        tag_symbol = "󰜝 ";
        style = "#edb46a";
        format = "[\($hash$tag\)]($style) ";
      };
      git_state = {
        style = "bold #f9ce31";
        format = "\([󱇯 $state( $progress_current/$progress_total)]($style)\) ";
      };
      git_status = {
        #style = "bold dimmed #fc5e46)";
        up_to_date = "✓(bold dimmed #82f2a4)";
        format = "([$all_status$ahead_behind](bold #edb46a) )";
      };
      */
      /*
         c = {
        format = "[$symbol($version(-$name) )]($style)";
        version_format = "v$raw";
        style = "fg:149 bold bg:0x86BBD8";
        symbol = " ";
        disabled = false;
        detect_extensions = [
          "c"
          "h"
        ];
        detect_files = [];
        detect_folders = [];
        commands = [
          [
            "cc"
            "--version"
          ]
          [
            "gcc"
            "--version"
          ]
          [
            "clang"
            "--version"
          ]
        ];
      };
      */
      container = {
        format = "[$symbol [$name]]($style)";
        style = "red bold dimmed";
        symbol = " ";
      };
      lua = {
        format = "[ $version](bold blue) ";
      };
      golang = {
        format = "[󰟓 ($version )($mod_version )](bold dimmed #00ADD8)";
      };
      php = {
        format = "[ $version](147 bold) ";
      };
      nodejs = {
        format = "[ ($version )](bold green)";
      };
      directory = {
        truncation_length = 2;
        read_only = " 󰈈 ";
        read_only_style = "bold #eeef8b";
        style = "bold #a4caea";
        use_os_path_sep = true;
        format = "[$path]($style)[$read_only]($read_only_style)[\\]\\$](bold #f26fa1) ";
        before_repo_root_style = "bold #f2cf6f";
        repo_root_style = "bold #f2cf6f";
        repo_root_format = "[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($repo_root_style)[$read_only]($read_only_style)[\\]\\$](bold #f26fa1) ";
      };
      hostname = {
        ssh_only = false;
        style = "bold #8bc5ef";
        format = "[$ssh_symbol](blue dimmed bold)[$hostname]($style) ";
        disabled = false;
      };
      username = {
        style_user = "bold #bba8ed";
        style_root = "bold red";
        show_always = true;
        format = "[\\[](bold #f26fa1)[$user]($style)[@](bold #f26fa1)";
      };
      nix_shell = {
        format = "[$state(($name))]($style) ";
        disabled = false;
        impure_msg = "[ ](bold red)";
        pure_msg = "[ ](bold blue)";
        style = "bold blue";
      };
      /*
      nix_shell = {
      symbol = "󰒷";
      impure_msg = "󰒷 (bold orange)";
      pure_msg = "󰒷 (bold blue)";
      unknown_msg = "󰒷 (bold yellow)";
      format = "[$state(\($name\))]";
      };
      */
    };
  };
}
