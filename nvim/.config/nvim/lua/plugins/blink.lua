return {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    -- event = "InsertEnter",
    version = "*",
    config = function()
        vim.cmd('highlight Pmenu guibg=none')
        vim.cmd('highlight PmenuExtra guibg=none')
        vim.cmd('highlight FloatBorder guibg=none')
        vim.cmd('highlight NormalFloat guibg=none')

        require("blink.cmp").setup({
            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "normal",
            },
            sources = {
                per_filetype = {
                    codecompanion = { "codecompanion" }
                },
                default = { "lsp", "path", "snippets", "buffer" },
                providers = {
                    cmdline = { min_keyword_length = 2 },
                },
            },
            completion = {
                menu = {
                    draw = {
                        columns = { { "kind_icon" }, { "label" } },
                    },
                }
            },
        })
    end,
}
