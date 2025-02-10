return {
    'tpope/vim-commentary',
    config = function()
        vim.keymap.set('n', '<leader>/', ':Commentary<CR>', {desc = 'Comment Line'})
        vim.keymap.set('v', '<leader>/', ':Commentary<CR>', {desc = 'Comment Visual Selection'})
    end
}