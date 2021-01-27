local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local helpers = require("helpers")
local pad = helpers.pad

-- Some commonly used variables
local playerctl_button_size = dpi(48)
local icon_size = dpi(36)
local progress_bar_width = dpi(215)
-- local progress_bar_margins = dpi(9)

local icon_font = "Typicons 90"
-- Item configuration
local exit_icon = wibox.widget.imagebox(beautiful.poweroff_icon)
exit_icon.resize = true
exit_icon.forced_width = icon_size
exit_icon.forced_height = icon_size
-- local exit_text_icon = ""
-- local exit_icon = wibox.widget.textbox(exit_text_icon)
-- exit_icon.font = "Typicons 30"
-- exit_icon.markup = helpers.colorize_text(exit_icon.text, beautiful.xcolor1)
local exit_text = wibox.widget.textbox(" Exit")
exit_text.font = "sans 14"

local exit = wibox.widget{
  exit_icon,
  nil,
  exit_text,
  layout = wibox.layout.fixed.horizontal
}
exit:buttons(gears.table.join(
                 awful.button({ }, 1, function ()
                     exit_screen_show()
                     sidebar.visible = false
                 end)
))

-- local weather_widget = require("noodle.weather")
-- local weather_widget_icon = weather_widget:get_all_children()[1]
-- weather_widget_icon.forced_width = icon_size
-- weather_widget_icon.forced_height = icon_size
-- local weather_widget_text = weather_widget:get_all_children()[2]
-- weather_widget_text.font = "sans 14"

-- Dummy weather_widget for testing
-- (avoid making requests with every awesome restart)
-- local weather_widget = wibox.widget.textbox("[i] bla bla bla!")

-- local weather = wibox.widget{
--     nil,
--     weather_widget,
--     nil,
--     layout = wibox.layout.align.horizontal,
--     expand = "none"
-- }

local temperature_icon = wibox.widget.imagebox(beautiful.temperature_icon)
temperature_icon.resize = true
temperature_icon.forced_width = icon_size
temperature_icon.forced_height = icon_size
-- local temperature_text_icon = ""
-- local temperature_icon = wibox.widget.textbox(temperature_text_icon)
-- temperature_icon.font = "Typicons 25"
-- temperature_icon.markup = helpers.colorize_text(temperature_icon.text, beautiful.xcolor1)

local temperature_bar = require("noodle.temperature_bar")
temperature_bar.forced_width = progress_bar_width
-- temperature_bar.margins.top = progress_bar_margins
-- temperature_bar.margins.bottom = progress_bar_margins
local temperature = wibox.widget{
  nil,
  {
    temperature_icon,
    pad(1),
    temperature_bar,
    pad(1),
    layout = wibox.layout.fixed.horizontal
  },
  nil,
  expand = "none",
  layout = wibox.layout.align.horizontal
}
temperature:buttons(
  gears.table.join(
    awful.button({ }, 1, function ()
        -- local matcher = function (c)
        --   return awful.rules.match(c, {name = 'watch sensors'})
        -- end
        -- awful.client.run_or_raise(terminal .." -e 'watch sensors'", matcher)
        awful.spawn(terminal .. " -e 'watch sensors'", {floating = true})
    end)
))

local battery_icon = wibox.widget.imagebox(beautiful.battery_icon)
battery_icon.resize = true
battery_icon.forced_width = icon_size
battery_icon.forced_height = icon_size
-- local battery_text_icon = ""
-- local battery_icon = wibox.widget.textbox(battery_text_icon)
-- battery_icon.font = "Typicons 25"
-- battery_icon.markup = helpers.colorize_text(battery_icon.text, beautiful.xcolor5)

awesome.connect_signal(
  "charger_plugged", function(c)
    battery_icon.image = beautiful.battery_charging_icon
end)
awesome.connect_signal(
  "charger_unplugged", function(c)
    battery_icon.image = beautiful.battery_icon
end)
local battery_bar = require("noodle.battery_bar")
battery_bar.forced_width = progress_bar_width
-- battery_bar.margins.top = progress_bar_margins
-- battery_bar.margins.bottom = progress_bar_margins
local battery = wibox.widget{
  nil,
  {
    battery_icon,
    pad(1),
    battery_bar,
    pad(1),
    layout = wibox.layout.fixed.horizontal
  },
  nil,
  expand = "none",
  layout = wibox.layout.align.horizontal
}

local cpu_icon = wibox.widget.imagebox(beautiful.cpu_icon)
cpu_icon.resize = true
cpu_icon.forced_width = icon_size
cpu_icon.forced_height = icon_size
-- local cpu_text_icon = ""
-- local cpu_icon = wibox.widget.textbox(cpu_text_icon)
-- cpu_icon.font = "Typicons 25"
-- cpu_icon.markup = helpers.colorize_text(cpu_icon.text, beautiful.xcolor2)
local cpu_bar = require("noodle.cpu_bar")
cpu_bar.forced_width = progress_bar_width
-- cpu_bar.margins.top = progress_bar_margins
-- cpu_bar.margins.bottom = progress_bar_margins
local cpu = wibox.widget{
  nil,
  {
    cpu_icon,
    pad(1),
    cpu_bar,
    pad(1),
    layout = wibox.layout.fixed.horizontal
  },
  nil,
  expand = "none",
  layout = wibox.layout.align.horizontal
}

cpu:buttons(
  gears.table.join(
    awful.button({ }, 1, function ()
        local matcher = function (c)
          return awful.rules.match(c, {name = 'htop'})
        end
        awful.client.run_or_raise(terminal .." -e htop", matcher)
    end),
    awful.button({ }, 3, function ()
        local matcher = function (c)
          return awful.rules.match(c, {class = 'Lxtask'})
        end
        awful.client.run_or_raise("lxtask", matcher)
    end)
))

local ram_icon = wibox.widget.imagebox(beautiful.ram_icon)
ram_icon.resize = true
ram_icon.forced_width = icon_size
ram_icon.forced_height = icon_size
-- local ram_text_icon = ""
-- local ram_icon = wibox.widget.textbox(ram_text_icon)
-- ram_icon.font = "Typicons 25"
-- ram_icon.markup = helpers.colorize_text(ram_icon.text, beautiful.xcolor14)

local ram_bar = require("noodle.ram_bar")
ram_bar.forced_width = progress_bar_width
-- ram_bar.margins.top = progress_bar_margins
-- ram_bar.margins.bottom = progress_bar_margins
local ram = wibox.widget{
  nil,
  {
    ram_icon,
    pad(1),
    ram_bar,
    pad(1),
    layout = wibox.layout.fixed.horizontal
  },
  nil,
  expand = "none",
  layout = wibox.layout.align.horizontal
}

ram:buttons(
  gears.table.join(
    awful.button({ }, 1, function ()
        local matcher = function (c)
          return awful.rules.match(c, {name = 'htop'})
        end
        awful.client.run_or_raise(terminal .." -e htop", matcher)
    end),
    awful.button({ }, 3, function ()
        local matcher = function (c)
          return awful.rules.match(c, {class = 'Lxtask'})
        end
        awful.client.run_or_raise("lxtask", matcher)
    end)
))


local playerctl_toggle_icon = wibox.widget.imagebox(beautiful.playerctl_toggle_icon)
-- local playerctl_toggle_icon = wibox.widget.imagebox(beautiful.playerctl_toggle_icon)
playerctl_toggle_icon.resize = true
playerctl_toggle_icon.forced_width = playerctl_button_size
playerctl_toggle_icon.forced_height = playerctl_button_size
playerctl_toggle_icon:buttons(gears.table.join(
                         awful.button({ }, 1, function ()
                             awful.spawn.with_shell("mpc toggle")
                         end),
                         awful.button({ }, 3, function ()
                             awful.spawn.with_shell("mpvc toggle")
                         end),
                         awful.button({ }, 8, function ()
                             sidebar.visible = false
                             awful.spawn.with_shell("~/scr/Rofi/rofi_mpvtube")
                         end),
                         awful.button({ }, 9, function ()
                             awful.spawn.with_shell("~/scr/info/mpv-query.sh")
                         end)
))

local playerctl_prev_icon = wibox.widget.imagebox(beautiful.playerctl_prev_icon)
playerctl_prev_icon.resize = true
playerctl_prev_icon.forced_width = playerctl_button_size
playerctl_prev_icon.forced_height = playerctl_button_size
playerctl_prev_icon:buttons(gears.table.join(
                         awful.button({ }, 1, function ()
                             awful.spawn.with_shell("mpc prev")
                         end),
                         awful.button({ }, 3, function ()
                             awful.spawn.with_shell("mpvc prev")
                         end)
))

local playerctl_next_icon = wibox.widget.imagebox(beautiful.playerctl_next_icon)
playerctl_next_icon.resize = true
playerctl_next_icon.forced_width = playerctl_button_size
playerctl_next_icon.forced_height = playerctl_button_size
playerctl_next_icon:buttons(gears.table.join(
                         awful.button({ }, 1, function ()
                             awful.spawn.with_shell("mpc next")
                         end),
                         awful.button({ }, 3, function ()
                             awful.spawn.with_shell("mpvc next")
                         end)
))

local playerctl_buttons = wibox.widget {
  nil,
  {
    playerctl_prev_icon,
    pad(1),
    playerctl_toggle_icon,
    pad(1),
    playerctl_next_icon,
    layout  = wibox.layout.fixed.horizontal
  },
  nil,
  expand = "none",
  layout = wibox.layout.align.horizontal,
}

local time = wibox.widget.textclock("%I:%M %p")
time.align = "center"
time.valign = "center"
time.font = "sans 55"

local date = wibox.widget.textclock("%B %d")
-- local date = wibox.widget.textclock("%A, %B %d")
-- local date = wibox.widget.textclock("%A, %B %d, %Y")
date.align = "center"
date.valign = "center"
date.font = "sans medium 16"

-- local fancy_date = wibox.widget.textclock("%-j days around the sun")
local fancy_date = wibox.widget.textclock("Knowing that today is %A fills you with determination.")
fancy_date.align = "center"
fancy_date.valign = "center"
fancy_date.font = "sans italic 11"

local mpd_song = require("noodle.mpd_song")
local mpd_widget_children = mpd_song:get_all_children()
local mpd_title = mpd_widget_children[1]
local mpd_artist = mpd_widget_children[2]
mpd_title.font = "sans medium 14"
mpd_artist.font = "sans 11"

-- Set forced height in order to limit the widgets to one line.
-- Might need to be adjusted depending on the font.
mpd_title.forced_height = dpi(24)
mpd_artist.forced_height = dpi(16)

mpd_song:buttons(gears.table.join(
                awful.button({ }, 1, function ()
                    awful.spawn.with_shell("mpc toggle")
                end),
                awful.button({ }, 3, function ()
                    -- Spawn music terminal
                    awful.spawn("music_terminal")
                end),
                awful.button({ }, 4, function ()
                    awful.spawn.with_shell("mpc prev")
                end),
                awful.button({ }, 5, function ()
                    awful.spawn.with_shell("mpc next")
                end)
))

local disk_space = require("noodle.disk")
disk_space.font = "sans 14"
local disk_icon = wibox.widget.imagebox(beautiful.files_icon)
disk_icon.resize = true
disk_icon.forced_width = icon_size
disk_icon.forced_height = icon_size
-- local disk_text_icon = ""
-- local disk_icon = wibox.widget.textbox(disk_text_icon)
-- disk_icon.font = "Typicons 25"
-- disk_icon.markup = helpers.colorize_text(disk_icon.text, beautiful.xcolor3)
local disk = wibox.widget{
  nil,
  {
    disk_icon,
    disk_space,
    layout = wibox.layout.fixed.horizontal
  },
  nil,
  expand = "none",
  layout = wibox.layout.align.horizontal
}

disk:buttons(gears.table.join(
                       awful.button({ }, 1, function ()
                           awful.spawn(filemanager, {floating = true})
                       end),
                       awful.button({ }, 3, function ()
                           awful.spawn(filemanager .. " /data", {floating = true})
                       end)
))

local search_icon = wibox.widget.imagebox(beautiful.search_icon)
search_icon.resize = true
search_icon.forced_width = icon_size
search_icon.forced_height = icon_size
local search_text = wibox.widget.textbox("Search")
search_text.font = "sans 14"

local search = wibox.widget{
  search_icon,
  search_text,
  layout = wibox.layout.fixed.horizontal
}
search:buttons(gears.table.join(
                 awful.button({ }, 1, function ()
                     awful.spawn.with_shell("rofi -show combi")
                     sidebar.visible = false
                 end),
                 awful.button({ }, 3, function ()
                     awful.spawn.with_shell("rofi -show run")
                     sidebar.visible = false
                 end)
))

local volume_icon = wibox.widget.imagebox(beautiful.volume_icon)
volume_icon.resize = true
volume_icon.forced_width = icon_size
volume_icon.forced_height = icon_size
-- local volume_text_icon = ""
-- local volume_icon = wibox.widget.textbox(volume_text_icon)
-- volume_icon.font = "Typicons 25"
-- volume_icon.markup = helpers.colorize_text(volume_icon.text, beautiful.xcolor6)
local volume_bar = require("noodle.volume_bar")
volume_bar.forced_width = progress_bar_width
-- volume_bar.shape = gears.shape.circle
-- volume_bar.margins.top = progress_bar_margins
-- volume_bar.margins.bottom = progress_bar_margins
local volume = wibox.widget{
  nil,
  {
    volume_icon,
    pad(1),
    volume_bar,
    pad(1),
    layout = wibox.layout.fixed.horizontal
  },
  nil,
  expand = "none",
  layout = wibox.layout.align.horizontal
}

volume:buttons(gears.table.join(
                 -- Left click - Mute / Unmute
                 awful.button({ }, 1, function ()
                     awful.spawn.with_shell("volume-control.sh toggle")
                 end),
                 -- Right click - Run or raise pavucontrol
                 awful.button({ }, 3, function () 
                     local matcher = function (c)
                       return awful.rules.match(c, {class = 'Pavucontrol'})
                     end
                     awful.client.run_or_raise("pavucontrol", matcher)
                 end),
                 -- Scroll - Increase / Decrease volume
                 awful.button({ }, 4, function () 
                     awful.spawn.with_shell("volume-control.sh up")
                 end),
                 awful.button({ }, 5, function () 
                     awful.spawn.with_shell("volume-control.sh down")
                 end)
))

-- Create the sidebar
sidebar = wibox({x = 0, y = 0, visible = false, ontop = true, type = "dock"})
sidebar.bg = beautiful.sidebar_bg or beautiful.wibar_bg or "#111111"
sidebar.fg = beautiful.sidebar_fg or beautiful.wibar_fg or "#FFFFFF"
sidebar.opacity = beautiful.sidebar_opacity or 1
sidebar.height = beautiful.sidebar_height or awful.screen.focused().geometry.height
sidebar.width = beautiful.sidebar_width or dpi(300)
sidebar.y = beautiful.sidebar_y or 0
local radius = beautiful.sidebar_border_radius or 0
if beautiful.sidebar_position == "right" then
  sidebar.x = awful.screen.focused().geometry.width - sidebar.width
  sidebar.shape = helpers.prrect(radius, true, false, false, true)
else
  sidebar.x = beautiful.sidebar_x or 0
  sidebar.shape = helpers.prrect(radius, false, true, true, false)
end
-- sidebar.shape = helpers.rrect(radius)

sidebar:buttons(gears.table.join(
                  -- Middle click - Hide sidebar
                  awful.button({ }, 2, function ()
                      sidebar.visible = false
                  end)
                  -- Right click - Hide sidebar
                  -- awful.button({ }, 3, function ()
                  --     sidebar.visible = false
                  --     -- mymainmenu:show()
                  -- end)
))

-- Hide sidebar when mouse leaves
if beautiful.sidebar_hide_on_mouse_leave then
  sidebar:connect_signal("mouse::leave", function ()
                           sidebar.visible = false
  end)
end

local s = mouse.screen
-- Activate sidebar by moving the mouse at the edge of the screen
if beautiful.sidebar_hide_on_mouse_leave then
  -- top left
  local sidebar_activator = wibox({x = s.geometry.width - 1, y = 0, height = beautiful.wibar_height, visible = true, ontop = false, opacity = 0, below = true})
  -- bottom left
  -- local sidebar_activator = wibox({x = 0, y = s.geometry.height - beautiful.wibar_height, height = beautiful.wibar_height, visible = true, ontop = false, opacity = 0, below = true})
  -- sidebar_activator.height = sidebar.height
  sidebar_activator.height = beautiful.wibar_height
  sidebar_activator:connect_signal("mouse::enter", function ()
                                     sidebar.visible = true
  end)

  if beautiful.sidebar_position == "right" then
    sidebar_activator.x = awful.screen.focused().geometry.width - sidebar_activator.width
  else
    sidebar_activator.x = 0
  end

  sidebar_activator:buttons(
    gears.table.join(
      -- awful.button({ }, 2, function ()
      --     start_screen_show()
      --     -- sidebar.visible = not sidebar.visible
      -- end),
      awful.button({ }, 4, function ()
          awful.tag.viewprev()
      end),
      awful.button({ }, 5, function ()
          awful.tag.viewnext()
      end)
  ))
end

-- Item placement
sidebar:setup {
  { ----------- TOP GROUP -----------
    pad(1),
    pad(1),
    time,
    date,
    pad(1),
    fancy_date,
    -- pad(1),
    -- weather,
    pad(1),
    pad(1),
    layout = wibox.layout.fixed.vertical
  },
  { ----------- MIDDLE GROUP -----------
    playerctl_buttons,
    {
      -- Put some padding at the left and right edge so that
      -- it looks better with extremely long titles/artists
      pad(2),
      mpd_song,
      pad(2),
      layout = wibox.layout.align.horizontal,
    },
    pad(1),
    pad(1),
    -- volume,
    cpu,
    temperature,
    ram,
    battery,
    pad(1),
    disk,
    pad(1),
    pad(1),
    layout = wibox.layout.fixed.vertical
  },
  { ----------- BOTTOM GROUP -----------
    { -- Search and exit screen
      nil,
      {
        -- search,
        -- pad(5),
        exit,
        pad(2),
        layout = wibox.layout.fixed.horizontal
      },
      nil,
      layout = wibox.layout.align.horizontal,
      expand = "none"
    },
    pad(1),
    layout = wibox.layout.fixed.vertical
  },
  layout = wibox.layout.align.vertical,
  -- expand = "none"
}
