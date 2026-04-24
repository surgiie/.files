-- -------------------------------------------------------------------------
-- Global Helper Functions
-- -------------------------------------------------------------------------

--- Check if a command is executable in the system PATH
--- @param cmd string The command name to check (e.g., 'git', 'node')
--- @return boolean True if the command is executable, false otherwise
_G.is_executable = function(cmd)
	return vim.fn.executable(cmd) == 1
end
