{
  programs.nixvim.plugins = {
    typescript-tools.enable = true;
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
      javascript = [["prettierd" "prettier"]];
      javascriptreact = [["prettierd" "prettier"]];
      typescript = [["prettierd" "prettier"]];
      typescriptreact = [["prettierd" "prettier"]];
      nix = ["alejandra"];
      # Use the "*" filetype to run formatters on all filetypes.
      "*" = ["codespell"];
      # Use the "_" filetype to run formatters on filetypes that don't
      # have other formatters configured.
      "_" = ["trim_whitespace"];
    };
    lsp-format.enable = true;
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
        # tsserver.enable = true;
        eslint.enable = true;
        gopls.enable = true;
        lua-ls.enable = true;
        nil_ls.enable = true;
        texlab.enable = true;
      };
    };
  };
}
