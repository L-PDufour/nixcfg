{
  programs.nixvim.autoGroups = {
    "YankHighlight" = {clear = true;};
  };
  programs.nixvim.autoCmd = [
    # Vertically center document when entering insert mode
    {
      event = "InsertEnter";
      command = "norm zz";
    }
    # Yank highlight
    {
      event = "TextYankPost";
      group = "YankHighlight";
      pattern = "*";
      callback = {
        __raw = ''
              function()
              vim.highlight.on_yank()
          end
        '';
      };
    }
    # Remove trailing whitespace on save
    {
      event = "BufWrite";
      command = "%s/\\s\\+$//e";
    }

    # Open help in a vertical split
    {
      event = "FileType";
      pattern = "help";
      command = "wincmd L";
    }

    # Set indentation to 2 spaces for nix files
    {
      event = "FileType";
      pattern = "nix";
      command = "setlocal tabstop=2 shiftwidth=2";
    }

    # Enable spellcheck for some filetypes
    {
      event = "FileType";
      pattern = [
        "tex"
        "latex"
        "markdown"
      ];
      command = "setlocal spell spelllang=en,fr";
    }
  ];
}
