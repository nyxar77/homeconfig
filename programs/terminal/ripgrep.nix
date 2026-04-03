{...}: {
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--hidden"
      "--smart-case"
      "--max-columns=150"
      "--max-columns-preview"

      # ignore heavy dirs
      "--glob=!**/node_modules/*"
      "--glob=!**/dist/*"
      "--glob=!**/target/*"
      "--glob=!**/.next/*"
      "--glob=!**/__pycache__/*"
      "--glob=!**/.venv/*"
      "--glob=!**/venv/*"
      "--glob=!**/.svelte-kit/*"
      "--glob=!**/.cache/*"
      "--glob=!**/.npm/*"
      "--glob=!**/.pnpm-store/*"

      # ignore noise files
      "--glob=!**/*.lock"
    ];
  };
}
