require("lualine").setup({
        icons_enabled = true,
        theme = "tokyonight",
        component_separators = "|",
        section_separators = "",
      sections = {},
      tabline = {
        lualine_a = { 'mode' },
        lualine_b = { 'hostname', 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
})


