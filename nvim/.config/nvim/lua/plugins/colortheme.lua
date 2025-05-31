return {
    'kepano/flexoki-neovim',
    name = 'flexoki',
    config = function()
        vim.cmd.colorscheme('flexoki-dark')
        -- vim.cmd.colorscheme('flexoki-light')

        vim.cmd.highlight({ "Normal", "guibg=NONE" })
        vim.cmd.highlight({ "Normal", "ctermbg=NONE" })
    end
}
