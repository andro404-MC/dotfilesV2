--==================--
-- Catppuccin Theme --
--==================--

local palette = {
	rosewater = "#bb9af7",
	flamingo = "#ff9e64",
	pink = "#f7768e",
	mauve = "#9d7cd8",
	red = "#f7768e",
	maroon = "#db4b4b",
	peach = "#ff9e64",
	yellow = "#e0af68",
	green = "#9ece6a",
	teal = "#73daca",
	sky = "#7dcfff",
	sapphire = "#2ac3de",
	blue = "#7aa2f7",
	lavender = "#bb9af7",
	text = "#a9b1d6",
	subtext1 = "#9aa5ce",
	subtext0 = "#cfc9c2",
	overlay2 = "#565f89",
	overlay1 = "#4f5779",
	overlay0 = "#414868",
	surface2 = "#24283b",
	surface1 = "#1f2335",
	surface0 = "#1a1b26",
	base = "#16161e",
	mantle = "#13131a",
	crust = "#0f0f14",
}

--- Gets the Catppuccin theme.
--- @return table theme Used in Yatline.
local function catppuccin_theme()
	local catppuccin_palette = palette

	return {
		-- yatline
		section_separator_open = "",
		section_separator_close = "",

		inverse_separator_open = "",
		inverse_separator_close = "",

		part_separator_open = "",
		part_separator_close = "",

		style_a = {
			fg = catppuccin_palette.mantle,
			bg_mode = {
				normal = catppuccin_palette.blue,
				select = catppuccin_palette.mauve,
				un_set = catppuccin_palette.red,
			},
		},
		style_b = { bg = catppuccin_palette.surface0, fg = catppuccin_palette.text },
		style_c = { bg = catppuccin_palette.gg, fg = catppuccin_palette.text },

		permissions_t_fg = catppuccin_palette.green,
		permissions_r_fg = catppuccin_palette.yellow,
		permissions_w_fg = catppuccin_palette.red,
		permissions_x_fg = catppuccin_palette.sky,
		permissions_s_fg = catppuccin_palette.lavender,

		selected = { icon = "󰻭", fg = catppuccin_palette.yellow },
		copied = { icon = "", fg = catppuccin_palette.green },
		cut = { icon = "", fg = catppuccin_palette.red },

		total = { icon = "", fg = catppuccin_palette.yellow },
		succ = { icon = "", fg = catppuccin_palette.green },
		fail = { icon = "", fg = catppuccin_palette.red },
		found = { icon = "", fg = catppuccin_palette.blue },
		processed = { icon = "", fg = catppuccin_palette.green },

		-- yatline-githead
		prefix_color = catppuccin_palette.subtext0,
		branch_color = catppuccin_palette.sapphire,
		commit_color = catppuccin_palette.mauve,
		stashes_color = catppuccin_palette.pink,
		state_color = catppuccin_palette.maroon,
		staged_color = catppuccin_palette.yellow,
		unstaged_color = catppuccin_palette.peach,
		untracked_color = catppuccin_palette.teal,
	}
end

return {
	setup = function(_, args)
		args = args or "mocha"

		return catppuccin_theme()
	end,
}
