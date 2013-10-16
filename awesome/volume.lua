volume_widget = widget({ type = "textbox", name = "tb_volume",
                         align = "right" })

-- display volume as a square, with size and opacity indicating level
function update_volume(widget)
    local fd = io.popen("amixer sget Master")
    local status = fd:read("*all")
    fd:close()

    local volume = tonumber(string.match(status, "(%d?%d?%d)%%")) / 100

    status = string.match(status, "%[(o[^%]]*)%]")

    -- starting colour
    local sr, sg, sb = 0x3F, 0x3F, 0x3F
    -- ending colour
    local er, eg, eb = 0xDC, 0xDC, 0xCC

    local ir = volume * (er - sr) + sr
    local ig = volume * (eg - sg) + sg
    local ib = volume * (eb - sb) + sb
    interpol_colour = string.format("%.2x%.2x%.2x", ir, ig, ib)

    local ticks = {'▁', '▂', '▃', '▄', '▅', '▆', '▇', '█'}
    local adjvol = math.ceil(volume * 7) + 1
    local volchar = ticks[adjvol]

    if string.find(status, "on", 1, true) then
        volume = " <span color='#" .. interpol_colour .. "'>♪ " .. volchar .. "</span> "
    else
        volume = " <span color='red'>♪ " .. volchar .. "</span> "
    end
    widget.text = volume
end

update_volume(volume_widget)
awful.hooks.timer.register(1, function () update_volume(volume_widget) end)

volume_widget:buttons(awful.util.table.join(
    awful.button({ }, 1,
        function()
            awful.util.spawn("amixer sset Master toggle")
            awful.util.spawn("amixer sset Front on")     -- turn volume on
            awful.util.spawn("amixer sset Headphone on")
            awful.util.spawn("amixer sset PCM on")
            update_volume(volume_widget)
        end),
    awful.button({}, 4,
        function()
            awful.util.spawn("amixer set Master 9%+")
            update_volume(volume_widget)
        end),
    awful.button({}, 5,
        function()
            awful.util.spawn("amixer set Master 9%-")
            update_volume(volume_widget)
        end)
))
