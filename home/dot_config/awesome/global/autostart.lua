local helpers = require "global.helpers"
local gears = require "gears"
local awful = require "awful"

-- Startup apps
helpers.run_once_pgrep "fcitx5"
--- picom
helpers.check_if_running("picom", nil, function()
	awful.spawn("picom --config " .. gears.filesystem.get_configuration_dir() .. "configs/picom.conf", false)
end)
helpers.run_once_pgrep "mpd"
helpers.run_once_pgrep "mpDris2"
--- Polkit Agent
helpers.run_once_ps("polkit-gnome-authentication-agent-1", "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
--- Other stuff
helpers.run_once_pgrep "blueman-applet"
helpers.run_once_pgrep "nm-applet --indicator"
-- helpers.run_once_pgrep(gears.filesystem.get_configuration_dir() .. "configs/nvidia-startup")
-- this will turn screen off when i3lock starts with xidlehook
awful.spawn.with_shell(
	[[echo "& sleep 5 && xset dpms force off" >> ]] .. gears.filesystem.get_configuration_dir() .. [[configs/lock]]
)
helpers.check_if_running("xidlehook", nil, function()
	helpers.run_once_pgrep(gears.filesystem.get_configuration_dir() .. "configs/xidlehook")
end)
helpers.run_once_pgrep "eval '$(ssh-agent -s)'"

-- st(terminal) live reload
-- requires 'xresources with signal reloading' patch
gears.timer {
	timeout = 1,
	call_now = true,
	autostart = true,
	single_shot = true,
	callback = function()
    awful.spawn.with_shell("pidof st | xargs kill -s USR1")
	end,
}
