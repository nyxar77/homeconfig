{ pkgs, ... }:
let
  catppuccinMocha = builtins.fromJSON (builtins.readFile ./anki-catppuccin-mocha.json);

  recolor = pkgs.ankiAddons.recolor.withConfig {
    config = catppuccinMocha;
  };

  fsrsHelper = pkgs.ankiAddons.fsrs4anki-helper.withConfig {
    config = {
      easy_dates = [ ];
      days_to_reschedule = 7;
      auto_reschedule_after_sync = false;
      auto_disperse_after_sync = false;
      auto_disperse_when_review = false;
      auto_disperse_after_reschedule = false;
      mature_ivl = 21;
      reschedule_threshold = 0;
      debug_notify = false;
      fsrs_stats = true;
      display_memory_state = false;
      has_rated = false;
      show_steps_stats = true;
      show_true_retention = true;
      "reschedule-set-due-date" = false;
    };
  };

  hyperTts = pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
    pname = "111623432";
    version = "3.6.0";

    src = pkgs.fetchurl {
      url = "https://github.com/Vocab-Apps/anki-hyper-tts/releases/download/v${finalAttrs.version}/anki-hyper-tts-${finalAttrs.version}.ankiaddon";
      hash = "sha256-d3NBSiMF53Cme+h+7BNSS4t2LsCuzDjRyisnso2bngQ=";
    };

    nativeBuildInputs = [ pkgs.unzip ];
    unpackPhase = ''
      runHook preUnpack
      unzip "$src"
      runHook postUnpack
    '';
  });
in
{
  home.packages = [ pkgs.anki ];

  # Link add-on contents individually so their directories stay writable for
  # runtime configuration and manually installed add-ons can coexist with them.
  home.file = {
    ".local/share/Anki2/addons21/recolor" = {
      source = "${recolor}/share/anki/addons/recolor";
      recursive = true;
    };
    ".local/share/Anki2/addons21/review-heatmap" = {
      source = "${pkgs.ankiAddons.review-heatmap}/share/anki/addons/review-heatmap";
      recursive = true;
    };
    ".local/share/Anki2/addons21/fsrs4anki-helper" = {
      source = "${fsrsHelper}/share/anki/addons/fsrs4anki-helper";
      recursive = true;
    };
    ".local/share/Anki2/addons21/anki-connect" = {
      source = "${pkgs.ankiAddons.anki-connect}/share/anki/addons/anki-connect";
      recursive = true;
    };
    ".local/share/Anki2/addons21/111623432" = {
      source = "${hyperTts}/share/anki/addons/111623432";
      recursive = true;
      force = true;
    };
  };
}
