local M = {}

M.menu     = "fuzzel"
M.mainMod  = "SUPER"
M.home     = os.getenv("HOME")
M.sounds   = M.home .. "/.files/sounds"

local nixPath = M.home .. "/.local/bin:/run/current-system/sw/bin:/run/wrappers/bin:" .. M.home .. "/.nix-profile/bin"

function M.exec(cmd)
	return function()
		hl.exec_cmd("env PATH=" .. nixPath .. " bash -c " .. string.format("%q", cmd))
	end
end

function M.local_bin(bin, ...)
	local args = { ... }
	local cmd = M.home .. "/.local/bin/" .. bin
	if #args > 0 then
		cmd = cmd .. " " .. table.concat(args, " ")
	end
	return M.exec(cmd)
end

return M
