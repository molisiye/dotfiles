-- ████████╗ ██████╗ ██████╗     ██████╗  █████╗ ███╗   ██╗███████╗██╗
-- ╚══██╔══╝██╔═══██╗██╔══██╗    ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║
--    ██║   ██║   ██║██████╔╝    ██████╔╝███████║██╔██╗ ██║█████╗  ██║
--    ██║   ██║   ██║██╔═══╝     ██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║
--    ██║   ╚██████╔╝██║         ██║     ██║  ██║██║ ╚████║███████╗███████╗
--    ╚═╝    ╚═════╝ ╚═╝         ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝

-- =========================================================
-- ======================= IMPORTS =========================
-- =========================================================

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local get_dpi = require("beautiful").xresources.get_dpi

--widgets
local TaskList = require("panels.top-panel.task-list")
local TagList = require("panels.top-panel.tag-list")
local mat_icon_button = require("widget.icon-button.icon-button")
local mat_icon = require("widget.icon-button.icon")
local icons = require("icons.fonticons")
local svgicons = require("icons.flaticons")
local helpers = require("global.helpers")
-- local weather = require("widget.weather.text_weather")

-- define module table
local top_panel = {}

-- =========================================================
-- ======================== SETUP ==========================
-- =========================================================

-- ------ Plus Button --------
--Rofi Launcher
local rofi_command = "env /usr/bin/rofi -dpi "
	.. get_dpi()
	.. " -width "
	.. dpi(400)
	.. " -show drun -theme "
	.. gears.filesystem.get_configuration_dir()
	.. "/configs/rofi/rofi-"
	.. beautiful.rofi_plus_sign
	.. ".rasi"
local add_button = mat_icon_button(mat_icon(svgicons.color_icon(svgicons.search, ICON_COLORS[COLORS]), dpi(15)))
add_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
	awful.spawn(
		rofi_command
		-- awful.screen.focused().selected_tag.defaultApp,
		-- {
		--     tag = _G.mouse.screen.selected_tag,
		--     placement = awful.placement.bottom_right
		-- }
	)
end)))

-- -- layoutBox Keybinds -----
local LayoutBox = function(s)
	local layoutBox = awful.widget.layoutbox(s)
	helpers.add_hover_cursor(layoutBox, "hand1")
	layoutBox.forced_width = beautiful.layoutbox_width
	layoutBox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	return layoutBox
end

-- Systray
local systray = require("panels.top-panel.systray")

-- --------- Date ------------
local date = wibox.widget.textclock(
	'<span font="' .. beautiful.date_time_font .. '" color="' .. beautiful.date_time_color .. '"> %a, %b %d   </span>'
)

local date_container = wibox.widget({
	{
		icons.setup({ name = icons.misc.calender }),
		date,
		layout = wibox.layout.fixed.horizontal,
	},
	shape = helpers.rrect(dpi(6)),
	bg = beautiful.widget_bg_normal,
	widget = wibox.container.background,
})

helpers.add_hover_cursor(date_container, "hand1")
date_container:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		awesome.emit_signal("date_dashboard::toggle", awful.screen.focused())
	end
end)
date_container:connect_signal("mouse::enter", function()
	date_container.bg = beautiful.accent_normal .. "4f"
end)
date_container:connect_signal("mouse::leave", function()
	date_container.bg = beautiful.widget_bg_normal
end)

local dc = wibox.container.margin(date_container, dpi(0), dpi(0), dpi(5), dpi(5))

-- --------- Clock -----------
local clock = function(s)
	local textclock = wibox.widget.textclock(
		'<span font="'
			.. beautiful.date_time_font
			.. '" color="'
			.. beautiful.date_time_color
			.. '"> %I:%M %p   </span>'
	)

	local textclock_container = wibox.widget({
		{
			icons.setup({
				name = icons.misc.clock,
			}),
			textclock,
			wibox.container.margin(LayoutBox(s), dpi(3), dpi(3), dpi(3), dpi(3)),
			helpers.horizontal_pad(dpi(6)),
			layout = wibox.layout.fixed.horizontal,
		},
		shape = helpers.rrect(dpi(6)),
		bg = beautiful.widget_bg_normal,
		widget = wibox.container.background,
	})
	local cc = wibox.container.margin(textclock_container, dpi(0), dpi(0), dpi(5), dpi(5))
	return cc
end

-- --------- Wifi ---------
--
local conn_state = [[sh -c "nmcli dev | grep wifi | sed 's/ \{2,\}/|/g' | cut -d '|' -f3 | head -1"]]
local wifi_name = [[sh -c "nmcli dev | grep wifi | sed 's/ \{2,\}/|/g' | cut -d '|' -f4 | head -1"]]

local state_text_icon = icons.setup({ name = icons.misc.wifi })

local wifi_name_text = wibox.widget({
	font = beautiful.date_time_font,
	markup = helpers.colorize_text("Disconnected", beautiful.date_time_color),
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
})

local update_text_icon = function()
	awful.spawn.easy_async_with_shell(conn_state, function(stdout)
		if string.match(stdout, "connected") then
			state_text_icon.markup = helpers.colorize_text(" 直 ", beautiful.icon_color)
		elseif string.match(stdout, "disconnected") then
			state_text_icon.markup = helpers.colorize_text(" 睊 ", beautiful.icon_color)
		else
			state_text_icon.markup = helpers.colorize_text(" 直? ", beautiful.icon_color)
		end
	end)
end

local update_wifi_text = function()
	awful.spawn.easy_async_with_shell(wifi_name, function(stdout)
		local name = stdout:gsub("%\n", "   ")
		wifi_name_text.markup = helpers.colorize_text(name, beautiful.date_time_color)
	end)
end

gears.timer({
	timeout = 10,
	autostart = true,
	call_now = true,
	callback = function()
		update_wifi_text()
		update_text_icon()
	end,
})

local wifi_container = wibox.widget({
	{
		state_text_icon,
		wifi_name_text,
		layout = wibox.layout.fixed.horizontal,
	},
	shape = helpers.rrect(dpi(6)),
	bg = beautiful.widget_bg_normal,
	widget = wibox.container.background,
})

helpers.add_hover_cursor(wifi_container, "hand1")
wifi_container:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		awesome.emit_signal("dashboard::toggle", awful.screen.focused())
	end
end)
wifi_container:connect_signal("mouse::enter", function()
	wifi_container.bg = beautiful.accent_normal .. "4f"
end)
wifi_container:connect_signal("mouse::leave", function()
	wifi_container.bg = beautiful.widget_bg_normal
end)

local wc = wibox.container.margin(wifi_container, dpi(0), dpi(0), dpi(5), dpi(5))

-- =========================================================
-- ======================= TOP BAR =========================
-- =========================================================

top_panel.create = function(s)
	local panel = wibox({
		ontop = true,
		screen = s,
		type = "dock",
		height = beautiful.wibar_height,
		width = s.geometry.width,
		x = s.geometry.x,
		y = s.geometry.y,
		stretch = false,
		bg = beautiful.bg_normal,
		fg = beautiful.fg_normal,
	})

	panel:struts({
		top = beautiful.wibar_height,
	})

	panel:setup({
		expand = "none",
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			wibox.container.margin(TaskList(s), dpi(2), dpi(2), dpi(3), dpi(3)),
			add_button,
		},
		wibox.container.margin(TagList(s), dpi(2), dpi(2), dpi(2), dpi(2)),
		{
			layout = wibox.layout.fixed.horizontal,
			-- weather,
			systray,
			helpers.horizontal_pad(dpi(6)),
			wc,
			helpers.horizontal_pad(dpi(6)),
			dc,
			helpers.horizontal_pad(dpi(6)),
			clock(s),
		},
	})

	awesome.connect_signal("panel::toggle", function(scr)
		if scr == s then
			s.panel.visible = not s.panel.visible
		end
	end)

	return panel
end
return top_panel
