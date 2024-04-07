{
  programs.nixvim.plugins.telescope = {
  extensions.file_browser.enable = true;
  extensions.ui-select.enable = true;
  extensions.fzf-native.enable = true;
  extensions.undo.enable = true;
    enable = true;
    defaults = {
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
      ".DS_Store"];
  "layout_strategy" = "horizontal";
  "layout_config" = {
      "prompt_position" = "top";
    };
    "sorting_strategy" = "ascending";
    };
    keymaps = {
      "<leader>?" = {
        action = "oldfiles";
        desc = "[?] Find recently opened files";
      };
      "<leader><space>" = {
        action = "buffers";
        desc = "[ ] Find existing buffers";
      };
      "<leader>/" = {
        action = "current_buffer_fuzzy_find";
        desc = "[/] Fuzzily search in current buffer]";
      };
      "<leader>sf" = {
        action = "find_files";
        desc = "[s]earch [f]iles";
      };
      "<leader>sh" = {
        action = "help_tags";
        desc = "[s]earch [h]elp";
      };
      "<leader>sw" = {
        action = "grep_string";
        desc = "[s]earch current [w]ord";
      };
      "<leader>sg" = {
        action = "live_grep";
        desc = "[s]earch by [g]rep";
      };
      "<leader>sd" = {
        action = "diagnostics";
        desc = "[s]earch [d]iagnotics";
      };
      "<leader>sD" = {
        action = "diagnostics, {}";
        desc = "[s]earch workspace [D]iagnotics";
      };
      "<leader>sk" = {
        action = "keymaps";
        desc = "[s]earch [k]eymaps";
      };
    };
  };
programs.nixvim.keymaps = [
      {
      action = "<cmd>:lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>";
      key = "<leader>dw";
      options = {
      desc = "[D]ocument [w]orkspace symbols";
      };
      }{
      action = "<cmd>:lua require('telescope.builtin').lsp_document_symbols()<CR>";
      key = "<leader>ds";
      options = {
      desc = "[D]ocument [s]ymbols";
      };
      }{
      action = "<cmd>:lua require('telescope.builtin').lsp_references()<CR>";
      key = "<leader>dr";
      options = {
      desc = "[D]ocument [r]eferences";
      };
      }
      {
      action = "<cmd>:lua require('telescope.builtin').lsp_definitions()<CR>";
      key = "<leader>df";
      options = {
      desc = "[D]ocument de[f]inition";
      };
      }
      {
        action = "<cmd>Telescope undo<CR>";
        key = "<leader>su";  # this line is changed
        mode = "n";
        options = {
          desc = "[s]earch [u]ndo";
        };
      }
{
        action = "<cmd>Telescope file_browser<CR>";
        key = "<leader>se";  # this line is changed
        mode = "n";
        options = {
          desc = "[s]earch file [e]xplorer";
        };
      }
    ];
}

