{...}: {
  imports = [./cliphist-wofi-img.nix];
  programs.wofi = {
    enable = true;
    settings = {
      allow_markup = true;
      insensitive = true;
      mode = "dmenu";
      location = "center";
      width = 600;
      height = 400;
      lines = 10;
    };

    style = ''
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
        padding: 12px;
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
        box-shadow: inset 0 0 0 1px rgba(233, 101, 165, 0.05);
      }

      #input:focus {
        border-color: @accent;
      }

      #inner-box {
        color: @text;
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

      #entry:selected {
        border-color: rgba(233, 101, 165, 0.66);
        border-left-color: @accent;
        color: @text;
        background-color: rgba(233, 101, 165, 0.18);
      }

      #entry:selected #text {
        color: @text;
      }

      #text {
        color: inherit;
      }
    '';
  };
}
