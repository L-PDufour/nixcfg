{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      ensureInstalled = "all";
      nixvimInjections = true;

      folding = true;
      indent = true;
    };

    treesitter-refactor = {
      enable = true;
      highlightDefinitions = {
        enable = true;
        # Set to false if you have an `updatetime` of ~100.
        clearOnCursorMove = false;
      };
    };

    hmts.enable = true;
  };
}
