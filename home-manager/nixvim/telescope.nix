{
  programs.nixvim.plugins.telescope = {
  extensions.file_browser.enable = true;
  extensions.ui-select.enable = true;
  extensions.undo.enable = true;
    enable = true;
    defaults = {
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
      "<leader>sk" = {
        action = "keymaps";
        desc = "[s]earch [k]eymaps";
      };
    };
  };
programs.nixvim.keymaps = [
      {
        action = "<cmd>Telescope undo<CR>";
        key = "<leader>su";  # this line is changed
        mode = "n";
        options = {
          desc = "Toggle Tree View.";
        };
      }
{
        action = "<cmd>Telescope file_browser<CR>";
        key = "<leader>se";  # this line is changed
        mode = "n";
        options = {
          desc = "Toggle Tree View.";
        };
      }
    ];
}

