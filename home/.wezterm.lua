local wezterm = require("wezterm")
local config = wezterm.config_builder()
local common = dofile(wezterm.home_dir .. "/.wezterm.common.lua")

config.enable_wayland = true
config.font_size = 16

local user = os.getenv("USER")
config.background = {
	{ source = { File = "/home/" .. user .. "/.files/terminal.jpg" }, hsb = { brightness = 0.1 } },
}

common.apply(config, {
	icon = "🔥",
	commands = {
		-- ── Git ───────────────────────────────────────────────────────────────
		{
			key = "gc",
			description = "Git — Commit — type message",
			execute = false,
			command = "git commit -m '<cursor>'",
		},
		{
			key = "gw",
			description = "Git — WIP — add all, commit, push",
			execute = false,
			command = "git add -A && git commit -m 'wip: <cursor>' && git push",
		},
		{ key = "ga", description = "Git — Add", command = "git add" },
		{ key = "gi", description = "Git — Rewrite — interactive rebase from selected commit", command = "git rewrite" },
		{
			key = "gs",
			description = "Git — Switch to selected branch",
			command = [=[branch=$(git branch --sort=-committerdate --format='%(refname:short)' | fzf --prompt='switch to> ') && [[ -n "$branch" ]] && git switch "$branch"]=],
		},
		{
			key = "gp",
			description = "Git — Cherry-pick selected commit",
			command = [=[hash=$(git log --all --oneline | fzf --prompt='cherry-pick> ' | awk '{print $1}') && [[ -n "$hash" ]] && git cherry-pick "$hash"]=],
		},
		{
			key = "gr",
			description = "Git — Restore file to selected commit",
			command = [=[file=$(git ls-files | fzf --prompt='restore file> ') && [[ -n "$file" ]] && ref=$(git log --oneline | fzf --prompt='restore from> ' | awk '{print $1}') && [[ -n "$ref" ]] && git restore --source="$ref" -- "$file"]=],
		},

		-- ── AWS ───────────────────────────────────────────────────────────────
		{
			key = "al",
			description = "AWS — SSO login — select profile",
			command = [=[profile=$(grep '^\[profile ' ~/.aws/config | sed 's/^\[profile //;s/\]$//' | fzf --prompt='profile> ') && [[ -n "$profile" ]] && aws sso login --profile "$profile"]=],
		},
		{
			key = "ae",
			description = "AWS — ECR docker login — select profile",
			command = [=[profile=$(grep '^\[profile ' ~/.aws/config | sed 's/^\[profile //;s/\]$//' | fzf --prompt='profile> ') && [[ -n "$profile" ]] && aws ecr get-login-password --profile "$profile" | docker login --username AWS --password-stdin "$(aws ecr describe-registry --profile "$profile" --query 'registryId' --output text).dkr.ecr.$(aws configure get region --profile "$profile").amazonaws.com"]=],
		},
		{
			key = "ap",
			description = "AWS — Set AWS_PROFILE — select profile",
			command = [=[profile=$(grep '^\[profile ' ~/.aws/config | sed 's/^\[profile //;s/\]$//' | fzf --prompt='profile> ') && [[ -n "$profile" ]] && export AWS_PROFILE="$profile" && echo "Set AWS_PROFILE to $profile"]=],
		},

		-- ── Browser ───────────────────────────────────────────────────────────
		{
			key = "bb",
			description = "Browser — Open a bookmark (fzf)",
			command = [=[url=$(jq -r '.roots | .. | objects | select(has("type") and .type == "url") | (if .name == "" then .url else .name end) + "\t" + .url' ~/.config/google-chrome/Default/Bookmarks | fzf --prompt='bookmarks> ' --with-nth=1 --delimiter=$'\t' | cut -f2) && [[ -n "$url" ]] && browse "$url"]=],
		},
		{
			key = "bs",
			description = "Browser — Search in browser",
			execute = false,
			command = "browse 'https://www.google.com/search?q=<cursor>'",
		},
		{ key = "bg", description = "Browser — Open current git repo", command = "git browse" },

		-- ── History ───────────────────────────────────────────────────────────
		{
			key = "hr",
			description = "History — Search and run from history",
			command = [=[cmd=$(grep -a '^: [0-9]*:[0-9]*;' ~/.zsh_history | strings | awk -F';' '{ $1=""; print substr($0,2) }' | tac | awk '!seen[$0]++' | fzf --prompt='history> ' --height=~40% --layout=reverse --border --no-sort) && [[ -n "$cmd" ]] && eval "$cmd"]=],
		},
		{
			key = "he",
			description = "History — Open history file in editor",
			command = "${EDITOR:-nvim} ~/.zsh_history",
		},

		-- ── Kubectl ───────────────────────────────────────────────────────────
		{
			key = "kn",
			description = "Kubectl — Switch namespace",
			command = "kns",
		},
		{
			key = "kl",
			description = "Kubectl — Log",
			execute = false,
			command = "kubectl logs:json <cursor>",
		},
		{
			key = "kc",
			description = "Kubectl — Switch context",
			command = "kctx",
		},

		-- ── Misc ──────────────────────────────────────────────────────────────
		{ key = "v",  description = "Neovim — Open in current directory", command = "nvim ." },
		{ key = "vs", description = "Neovim — Scratchpad",                command = "nvim-scratch" },
	},
})

return config
