{
  programs.nixvim.plugins = {
    # typescript-tools.enable = true;
    conform-nvim.enable = true;
    conform-nvim.formatOnSave = {
      lspFallback = true;
      timeoutMs = 500;
    };
    conform-nvim.notifyOnError = true;
    conform-nvim.formattersByFt = {
      lua = ["stylua"];
      # Conform will run multiple formatters sequentially
      python = ["isort" "black"];
      # Use a sub-list to run only the first available formatter
      html = [["prettierd" "prettier"]];
      css = [["prettierd" "prettier"]];
      javascript = [["prettier"]];
      javascriptreact = [["prettier"]];
      typescript = [["prettier"]];
      typescriptreact = [["prettier"]];
      nix = ["alejandra"];
      # Use the "*" filetype to run formatters on all filetypes.
      # Use the "_" filetype to run formatters on filetypes that don't
      # have other formatters configured.
      "_" = ["trim_whitespace"];
    };
    lsp-format.enable = true;
    lsp-format.lspServersToEnable = "all";
    lsp = {
      enable = true;
      keymaps = {
        silent = true;
        diagnostic = {
          # Navigate in diagnostics
          "[d" = "goto_prev";
          "]d" = "goto_next";
        };

        lspBuf = {
          "<leader>ca" = "code_action";
          K = "hover";
          "<leader>rn" = "rename";
        };
      };

      servers = {
        clangd.enable = true;
        tsserver.enable = true;
        eslint.enable = true;
        gopls.enable = true;
        lua-ls.enable = true;
        nil-ls.enable = true;
        # texlab.enable = true;
        templ.enable = true;
        htmx.enable = true;
        tailwindcss.enable = true;
      };
    };
  };
}
