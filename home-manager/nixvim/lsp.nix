{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;

      keymaps = {
        silent = true;
        diagnostic = {
          # Navigate in diagnostics
          "<leader>k" = "goto_prev";
          "<leader>j" = "goto_next";
        };

        lspBuf = {
          "<leader>ca" = "code_action";
          gd = "definition";
          gD = "references";
          gt = "type_definition";
          gi = "implementation";
          K = "hover";
          "<F2>" = "rename";
        };
      };

      servers = {
        clangd.enable = true;
        lua-ls.enable = true;
        nil_ls.enable = true;
        texlab.enable = true;
      };
    };
  };
}