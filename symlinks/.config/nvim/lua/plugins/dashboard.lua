return {
	"glepnir/dashboard-nvim",
    event = "VimEnter",
    requires = {'nvim-tree/nvim-web-devicons'},
	config = function()
		local dashboard = require('dashboard')
        local header = {
        '█▀ █ █ █▀█ █▀▀ █ █ █▀▀',
        '▄█ █▄█ █▀▄ █▄█ █ █ ██▄',
        '',
        '',
        '',
        }

        local center = {
            { icon = '            ', desc = '      Open A New File                       ', action = 'enew' },
            { icon = '            ', shortcut = 'SPC f', desc = '      Find A File                 ', action = 'Telescope find_files' },
            { icon = '            ', shortcut = 'SPC h', desc = '      Show Recent Files              ', action = 'Telescope oldfiles' },
            { icon = '            ', shortcut = 'SPC g', desc = '      Search For Word                 ', action = 'Telescope live_grep' },
        }
        local config = {
            header = header,
            center = center,
            footer = { '' }
        }
        dashboard.setup({
            theme = "doom",
            config = config
        })


        local function pad(config)
            local height = vim.api.nvim_win_get_height(0)
            local center = math.ceil( height / 2)
            local dbc = math.ceil((#config.center + #config.center - 1 + #config.header + #config.footer) / 2)
            for i =1 , center -dbc do
                table.insert(config.header, 1, '')
            end
        end

        pad(config)


        vim.cmd([[
        augroup DashboardHighlights
            autocmd ColorScheme * highlight DashboardHeader guifg=#ffffff
            autocmd ColorScheme * highlight DashboardCenter guifg=#f8f8f2
            autocmd ColorScheme * highlight DashboardShortcut guifg=#bd93f9
            autocmd ColorScheme * highlight DashboardFooter guifg=#ffffff
        augroup end
        ]])
        vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#ffffff' })
        vim.api.nvim_set_hl(0, 'DashboardCenter', { fg = '#f8f8f2' })
        vim.api.nvim_set_hl(0, 'DashboardShortcut', { fg = '#bd93f9' })
        vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = '#ffffff' })
	end
}
