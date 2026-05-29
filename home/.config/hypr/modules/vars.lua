local M = {}

M.menu     = "fuzzel"
M.mainMod  = "SUPER"
M.home     = os.getenv("HOME")
M.sounds   = M.home .. "/.files/sounds"

local nixPath = "/run/current-system/sw/bin:/run/wrappers/bin:" .. M.home .. "/.local/bin:" .. M.home .. "/.nix-profile/bin"

function M.exec(cmd)
	return function()
		hl.exec_cmd("env PATH=" .. nixPath .. " bash -c " .. string.format("%q", cmd))
	end
end

return M
