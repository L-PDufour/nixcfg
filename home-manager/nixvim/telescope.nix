{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions.file-browser.enable = true;
    extensions.ui-select.enable = true;
    extensions.fzf-native.enable = true;
    extensions.undo.enable = true;
    settings.defaults = {
      mappings = {
        i = {
          "<c-enter>" = {
            __raw = "to_fuzzy_refine";
          };
        };
      };
      "file_ignore_patterns" = [
        "node_modules"
        ".git"
        ".cache"
        ".vscode"
        ".idea"
        ".DS_Store"
      ];
      "layout_strategy" = "horizontal";
      "layout_config" = {
        "prompt_position" = "top";
      };
      "sorting_strategy" = "ascending";
    };
    keymaps = {
      "<leader>?" = {
        action = "oldfiles";
        options.desc = "[?] Find recently opened files";
      };
      "<leader><space>" = {
        action = "buffers";
        options.desc = "[ ] Find existing buffers";
      };
      "<leader>sf" = {
        action = "find_files";
        options.desc = "[f]iles";
      };
      "<leader>sh" = {
        action = "help_tags";
        options.desc = "[h]elp";
      };
      "<leader>sw" = {
        action = "grep_string";
        options.desc = "[w]ord";
      };
      "<leader>sg" = {
        action = "live_grep";
        options.desc = "[g]rep";
      };
      "<leader>sd" = {
        action = "diagnostics";
        options.desc = "[d]iagnotics";
      };
      "<leader>sD" = {
        action = "diagnostics, {}";
        options.desc = "[D]iagnotics";
      };
      "<leader>sk" = {
        action = "keymaps";
        options.desc = "[k]eymaps";
      };
    };
  };
  programs.nixvim.keymaps = [
    {
      action = "<cmd>:lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>";
      key = "<leader>dw";
      options = {
        desc = "[w]orkspace symbols";
      };
    }
    {
      action = "<cmd>:lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({winblend = 10,previewer = false}))<CR>";
      key = "<leader>/";
      options = {desc = "[/] current buffer fuzzy find";};
    }
    {
      action = "<cmd>:lua require('telescope.builtin').lsp_document_symbols()<CR>";
      key = "<leader>ds";
      options = {
        desc = "[s]ymbols";
      };
    }
    {
      action = "<cmd>:lua require('telescope.builtin').lsp_references()<CR>";
      key = "<leader>dr";
      options = {
        desc = "[r]eferences";
      };
    }
    {
      action = "<cmd>:lua require('telescope.builtin').lsp_definitions()<CR>";
      key = "<leader>df";
      options = {
        desc = "de[f]inition";
      };
    }
    {
      action = "<cmd>Telescope undo<CR>";
      key = "<leader>su"; # this line is changed
      mode = "n";
      options = {
        desc = "[u]ndo";
      };
    }
    {
      action = "<cmd>Telescope file_browser<CR>";
      key = "<leader>se"; # this line is changed
      mode = "n";
      options = {
        desc = "file [e]xplorer";
      };
    }
    {
      action = "which_key_ignore";
      key = "<leader>d"; # this line is changed
      mode = "n";
      options = {
        desc = "[d]ocument";
      };
    }
    {
      action = "which_key_ignore";
      key = "<leader>s"; # this line is changed
      mode = "n";
      options = {
        desc = "[s]earch";
      };
    }
  ];
}
