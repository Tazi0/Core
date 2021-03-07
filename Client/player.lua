AddEventHandler("koth:teleport", function(x, y, z, r, model, fade)
    if x == nil or y == nil then return false end
    if z == nil then z = GetHeightmapTopZForPosition(x, y) + 4 end
    if r == nil then r = 0 end
    if model == nil then model = "s_m_m_chemsec_01" end
    if fade == nil then fade = true end

    exports.spawnmanager:spawnPlayer({
        x = x + .0,
        y = y + .0,
        z = z + .0,
        heading = r + .0,
        model = model,
        skipFade = not fade
    })
end)