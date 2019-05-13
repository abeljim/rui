local awful = require("awful")
local gears = require("gears")
local beautiful  = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")

local bindings = {}

-- Focus by direction "left", "right, "up", "down"
bindings.focus_client = function(direction)
    awful.client.focus.bydirection(direction)
    if client.focus then client.focus:raise() end
end

-- Kills all visble clients for the current tag
bindings.kill_clients = function()
    local clients = awful.screen.focused().clients
    for _,c in pairs(clients) do
        c:kill()
    end
end

-- Layout manipulation "up, "down"
bindings.move_layout = function(direction)
    local current_layout = helpers.find_curr_layout()
    local c = client.focus

    -- Floating: move client to edge
    if c ~= nil and (current_layout == "floating" or c.floating) then
        helpers.move_to_edge(c, direction)
    else
        awful.client.swap.bydirection(direction, c, nil)
    end
end

-- Jump to Urgent Client
bindings.jump_urgent = function()
    uc = awful.client.urgent.get()

    if uc == nil then
        awful.tag.history.restore()
    else
        awful.client.urgent.jumpto()
    end
end

-- Go to Previous Client
bindings.previous_client = function()
    awful.client.focus.history.previous()
    if client.focus then
        client.focus:raise()
    end
end

-- Shift Client Left

return bindings
