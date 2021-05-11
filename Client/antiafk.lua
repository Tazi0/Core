local PedHeading = nil
local PedHeadingCurrent = nil
local PedPos = nil
local PedPosCurrent = nil
local afktimer = Config.Afktimer
local ped = nil

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(1000)
		ped = PlayerPedId()
		if ped ~= nil then
			PedPosCurrent = GetEntityCoords(ped)
			PedHeadingCurrent = GetEntityHeading(ped)
			if PedPosCurrent == PedPos and PedHeadingCurrent == PedHeading then
				afktimer = afktimer-1
				if afktimer == 60 then
					TriggerEvent('chat:addMessage', {color = { 255, 0, 0},multiline = true,args = {"SERVER:", " "..Lang["en"].player.afkMessage}})
				elseif afktimer == 30 then
					TriggerEvent('chat:addMessage', {color = { 255, 0, 0},multiline = true,args = {"SERVER:", " "..Lang["en"].player.afkMessage}})
				elseif afktimer == 10 then
					TriggerEvent('chat:addMessage', {color = { 255, 0, 0},multiline = true,args = {"SERVER:", " "..Lang["en"].player.afkMessage}})
				elseif afktimer < 1 then
					TriggerServerEvent("koth:afkkick")
				end
			else
				afktimer = Config.Afktimer
				PedPos = PedPosCurrent
				PedHeading = PedHeadingCurrent
			end

		else
			Wait(5000)
		end
    end
end)
