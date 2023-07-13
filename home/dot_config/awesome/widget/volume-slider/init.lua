local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local spawn = awful.spawn
local dpi = beautiful.xresources.apply_dpi
local helpers = require("global.helpers")
local icons = require("icons.flaticons")

local slider =
wibox.widget {
	nil,
	{
		id = "volume_slider",
		bar_shape = gears.shape.rounded_rect,
		bar_height = dpi(2),
		bar_color = "#ffffff20",
		bar_active_color = beautiful.accent_normal .. "80",
		handle_color = beautiful.accent_normal,
		handle_shape = gears.shape.circle,
		handle_width = dpi(15),
		handle_border_color = "#00000012",
		handle_border_width = dpi(1),
		maximum = 150,
		widget = wibox.widget.slider
	},
	nil,
	forced_height = dpi(24),
	expand = "none",
	layout = wibox.layout.align.vertical
}

local volume_slider = slider.volume_slider

-- set volume using slider value
volume_slider:connect_signal(
	"property::value",
	function()
		local volume_level = volume_slider:get_value()
		spawn("pactl set-sink-volume 0 " .. volume_level .. "%", false)
		-- Update volume osd
		awesome.emit_signal("module::volume_osd", volume_level)
		-- Update icon
		awesome.emit_signal("module::volume_icon", volume_level)
	end
)

volume_slider:buttons(
	gears.table.join(
		awful.button(
			{},
			4,
			nil,
			function()
				if volume_slider:get_value() > 150 then
					volume_slider:set_value(150)
					return
				end
				volume_slider:set_value(volume_slider:get_value() + 5)
			end
		),
		awful.button(
			{},
			5,
			nil,
			function()
				if volume_slider:get_value() < 0 then
					volume_slider:set_value(0)
					return
				end
				volume_slider:set_value(volume_slider:get_value() - 5)
			end
		)
	)
)

local update_slider = function()
	awful.spawn.easy_async_with_shell(
		[[pactl get-sink-volume 0]],
		function(stdout)
			local volume = string.match(stdout, "(%d?%d?%d)%%")
			volume_slider:set_value(tonumber(volume))
			awesome.emit_signal("module::volume_icon", tonumber(volume))
		end
	)
end

-- Update on startup with delay
gears.timer {
	timeout     = 5,
	call_now    = true,
	autostart   = true,
	single_shot = true,
	callback    = function()
		update_slider()
	end
}

local mute_toggle = wibox.container.background(
	helpers.imaker(icons.color_icon(icons.volume2, ICON_COLORS[COLORS])),
	beautiful.widget_bg_normal,
	gears.shape.circle
)

local update_icon = function(volume_level)
	awful.spawn.easy_async_with_shell(
		[[pactl get-sink-mute 0]], function(stdout)
		if string.match(stdout, "no") then
			if volume_level <= 50 and volume_level > 0 then
				mute_toggle.widget = helpers.imaker(icons.color_icon(icons.volume0, ICON_COLORS[COLORS]))
			elseif volume_level <= 100 and volume_level > 50 then
				mute_toggle.widget = helpers.imaker(icons.color_icon(icons.volume1, ICON_COLORS[COLORS]))
			elseif volume_level <= 150 and volume_level > 100 then
				mute_toggle.widget = helpers.imaker(icons.color_icon(icons.volume2, ICON_COLORS[COLORS]))
			end
		else
			mute_toggle.widget = helpers.imaker(icons.color_icon(icons.volumex, ICON_COLORS[COLORS]))
		end
		mute_toggle:emit_signal("widget::redraw_needed")
	end
	)
end

-- signal from slider to update icon on vol change
awesome.connect_signal(
	"module::volume_icon",
	function(volume)
		update_icon(volume)
	end
)

helpers.add_hover_cursor(mute_toggle, "hand1")

mute_toggle:buttons(
	gears.table.join(
		awful.button(
			{},
			1,
			nil,
			function()
				awful.spawn.easy_async_with_shell([[bash -c "pactl set-sink-mute 0 toggle"]], function()
					awesome.emit_signal("module::volume_icon", volume_slider:get_value())
				end)
			end
		),
		awful.button(
			{},
			3,
			nil,
			function()
				awful.spawn(apps.soundctrlpanel)
			end
		)
	)
)
mute_toggle:connect_signal(
	"mouse::enter",
	function()
		mute_toggle.bg = beautiful.accent_normal .. "32"
	end
)
mute_toggle:connect_signal(
	"mouse::leave",
	function()
		mute_toggle.bg = beautiful.widget_bg_normal
	end
)

-- The emit will come from the global keybind
awesome.connect_signal(
	"widget::volume",
	function()
		update_slider()
	end
)

-- The emit will come from the OSD
awesome.connect_signal(
	"widget::volume:update",
	function(value)
		volume_slider:set_value(tonumber(value))
		update_icon(tonumber(value))
	end
)

local volume_widget = wibox.widget {
	{
		{
			mute_toggle,
			top = dpi(12),
			bottom = dpi(12),
			widget = wibox.container.margin
		},
		slider,
		spacing = dpi(24),
		layout = wibox.layout.fixed.horizontal
	},
	left = dpi(24),
	right = dpi(24),
	forced_height = dpi(48),
	widget = wibox.container.margin
}

return volume_widget
