return {
    "folke/which-key.nvim",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("which-key").setup {
            -- disable autopopup, i like to manually call :WhichKey when i need it
            triggers = {
            }
        }
    end
}