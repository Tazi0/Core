local vehicles = {}

RegisterNetEvent("koth:kill")
AddEventHandler("koth:kill", function(killer, vehicle)
    local player = KOTH.Cache.Players[tostring(killer)]

    if player == nil then return false end

    local money = player.Money
    local amount = tonumber(Config.Kill.Player)

    if vehicle ~= nil and has_value(vehicles, vehicle) ~= true then
        -- Vehicle has been killed
        amount = amount + tonumber(Config.Kill.Vehicle)

        table.insert(vehicles, vehicle) -- This will stop the loop of extra paying for vehicle

        money:add(amount)
        TriggerClientEvent("koth:notifications", killer, "You killed a vehicle with a player inside! ~y~" .. Config.Kill.Currency .. tostring(Config.Kill.Vehicle) .. "~s~ got added to your account")
        TriggerClientEvent("koth:notification", killer, "You killed " .. GetPlayerName(source) .. " and made ~y~" .. Config.Kill.Currency .. tostring(Config.Kill.Player))
    else
        -- Player killed | Vehicle kill but already given vehicle money
        money:add(amount)
        TriggerClientEvent("koth:notification", killer, "You killed " .. GetPlayerName(source) .. " and made ~y~" .. Config.Kill.Currency .. tostring(Config.Kill.Player))
    end
end)