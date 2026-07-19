-- Hyprland Lua configuration
-- One-to-one Lua port of ~/.config/hypr/hyprland.conf.

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "nautilus"
local browser = "firefox"

hl.on("hyprland.start", function()
	hl.exec_cmd("bash ~/.config/hypr/start.sh")
end)

local scheme = dofile(os.getenv("HOME") .. "/.config/hypr/scheme/current.lua")

local function rgba(name, alpha)
	return "rgba(" .. scheme[name] .. (alpha or "ff") .. ")"
end

-- hl.env("XCURSOR_SIZE", "24")
-- hl.env("XCURSOR_THEME", "catppuccin-mocha-red-cursors")
-- hl.env("HYPRCURSOR_SIZE", "24")
-- hl.env("HYPRCURSOR_THEME", "catppuccin-mocha-red-cursors")

-- Disabled in hyprland.conf:
-- source = ~/.config/hypr/scheme/current.conf

hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 10,
		border_size = 2,
		col = {
			active_border = {
				colors = {
					rgba("primary"),
					rgba("secondary"),
					rgba("tertiary"),
				},
				angle = 45,
			},
			inactive_border = rgba("outlineVariant", "aa"),
			nogroup_border = rgba("error", "aa"),
			nogroup_border_active = rgba("error"),
		},
		resize_on_border = true,
		allow_tearing = false,
		layout = "master",
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = rgba("shadow", "ee"),
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
		background_color = rgba("base"),
	},

	input = {
		kb_layout = "fr,ara",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = true,
		},
	},
})

hl.curve("easeOutQuint", {
	type = "bezier",
	points = {
		{ 0.23, 1 },
		{ 0.32, 1 },
	},
})
hl.curve("linear", {
	type = "bezier",
	points = {
		{ 0, 0 },
		{ 1, 1 },
	},
})
hl.curve("almostLinear", {
	type = "bezier",
	points = {
		{ 0.5, 0.5 },
		{ 0.75, 1 },
	},
})
hl.curve("quick", {
	type = "bezier",
	points = {
		{ 0.15, 0 },
		{ 0.1, 1 },
	},
})
hl.curve("silk", {
	type = "bezier",
	points = {
		{ 0.2, 0.8 },
		{ 0.2, 1 },
	},
})
hl.curve("drift", {
	type = "bezier",
	points = {
		{ 0.18, 0.65 },
		{ 0.25, 1 },
	},
})
hl.curve("settle", {
	type = "bezier",
	points = {
		{ 0.25, 0.46 },
		{ 0.45, 0.94 },
	},
})

hl.animation({ leaf = "global", enabled = true, speed = 1, bezier = "silk" })
hl.animation({ leaf = "border", enabled = true, speed = 5.5, bezier = "settle" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.2, bezier = "silk" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.6, bezier = "drift", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3.2, bezier = "settle", style = "slide" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 3.8, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 3.0, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.8, bezier = "settle" })
hl.animation({ leaf = "layers", enabled = true, speed = 4.8, bezier = "silk" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 5.0, bezier = "drift", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3.4, bezier = "settle", style = "slide" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 3.8, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 3.0, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3.8, bezier = "silk", style = "slidefade 20%" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3.8, bezier = "silk", style = "slidefade 20%" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3.4, bezier = "settle", style = "slidefade 20%" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 5.2, bezier = "silk" })

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
-- hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + V", function()
	hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
	hl.dispatch(hl.dsp.window.resize({ x = 900, y = 600, relative = false }))
	hl.dispatch(hl.dsp.window.center())
end)

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
-- hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("caelestia shell picker open"))

-- Caelestia shell
hl.bind(mainMod .. " + A", hl.dsp.global("caelestia:dashboard"))
hl.bind(mainMod .. " + N", hl.dsp.global("caelestia:sidebar"))
hl.bind(mainMod .. " + X", hl.dsp.global("caelestia:session"))
hl.bind(mainMod .. " + L", hl.dsp.global("caelestia:lock"))
hl.bind(mainMod .. " + SPACE", hl.dsp.global("caelestia:launcher"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.global("caelestia:showall"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("caelestia wallpaper -r -N"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.global("caelestia:clearNotifs"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("systemctl --user restart caelestia.service; hyprctl reload"))

-- Caelestia utilities
hl.bind(mainMod .. " + M", hl.dsp.global("caelestia:screenshot"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.global("caelestia:screenshotFreeze"))
hl.bind("Print", hl.dsp.exec_cmd("caelestia screenshot"), { locked = true })
hl.bind(mainMod .. " + PERIOD", hl.dsp.exec_cmd("caelestia emoji -p"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("caelestia-theme-wofi"))
hl.bind(mainMod .. " + J", hl.dsp.exec_cmd("cliphist-wofi-img"))
-- Projector UI backed by the transactional projector controller.
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("projector-panel"))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

for i = 1, 10 do
	local key = "code:" .. (i + 9)
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.global("caelestia:brightnessUp"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.global("caelestia:brightnessDown"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.global("caelestia:mediaToggle"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.global("caelestia:mediaToggle"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.global("caelestia:mediaNext"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.global("caelestia:mediaPrev"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.global("caelestia:mediaStop"), { locked = true })
hl.bind("Caps_Lock", hl.dsp.global("caelestia:refreshDevices"), { locked = true, non_consuming = true })
hl.bind("Num_Lock", hl.dsp.global("caelestia:refreshDevices"), { locked = true, non_consuming = true })
hl.bind("Caps_Lock", hl.dsp.global("caelestia:refreshDevices"), { locked = true, non_consuming = true })
hl.bind("Num_Lock", hl.dsp.global("caelestia:refreshDevices"), { locked = true, non_consuming = true })

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "nofocus-empty-xwayland-window",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "^(hyprland-run)$" },
	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	name = "xdg-portal-gtk-file-picker",
	match = { class = "^(xdg-desktop-portal-gtk|org.freedesktop.impl.portal.desktop.gtk)$" },
	float = true,
	center = true,
	size = "980 660",
})

hl.window_rule({
	name = "xdg-portal-hyprland-share-picker",
	match = { class = "^(xdg-desktop-portal-hyprland|hyprland-share-picker)$" },
	float = true,
	center = true,
	size = "560 420",
})

hl.window_rule({
	name = "xdg-portal-hyprland-share-picker-title",
	match = { title = "^(Select what to share|Screen Share|Share|Choose what to share)$" },
	float = true,
	center = true,
	size = "560 420",
})

hl.window_rule({
	name = "xdg-portal-hyprland-share-picker-fuzzy-title",
	match = {
		title = ".*(Select what to share|Choose what to share|Screen Share|Share Screen|share picker|Share Picker).*",
	},
	float = true,
	center = true,
	size = "560 420",
})
