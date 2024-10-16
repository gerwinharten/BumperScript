if exports.es_extended:getSharedObject() then
    ESX = exports.es_extended:getSharedObject()
    print("New ESX Auto-Detected")
else
    ESX = nil
	Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    print("Old ESX Auto-Detected")
end)
end

local Autoscooterpunkt = Config.BuyPoint

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)  
        
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local distance = #(playerCoords - Autoscooterpunkt)
        if distance <= 10.0 then 
            DrawMarker(1, Autoscooterpunkt.x, Autoscooterpunkt.y, (Autoscooterpunkt.z - 1.0), 
                       0.0, 0.0, 0.0, 0.0, 0.0, 0.0, (2.0 * 1.7), (2.0 * 1.7), 0.3, 
                       20, 200, 200, 50, false, false, 2, false, false, false, false)
        end
        if distance <= 2.0 then 
					if IsPedInAnyVehicle(PlayerPedId(), false) then
				            ESX.ShowHelpNotification(_( 'is_in_vehicle'))
			else
				            ESX.ShowHelpNotification(_( 'buy_ticket_prompt'))
            if IsControlJustPressed(0, 38) then 
					OpenTicketMenu()
            end
				end

        end
    end
end)


function OpenTicketMenu()
    local Elements = {
        {label = _( 'buy_ticket'), name = "ticketskaufen"},
        {label = _( 'cancel'), name = "abbrechen"},
    }

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "tickets", {
        title = _( 'menu_title'),
        align    = 'top-left',
        elements = Elements
    }, function(data,menu)
        if data.current.name == "ticketskaufen" then
            local input = lib.inputDialog(_( 'input_dialog_title'), {_( 'input_dialog_prompt')})
            if input and tonumber(input[1]) then
                local ticketCount = tonumber(input[1])
                ESX.ShowNotification(_( 'buy_ticket_success', ticketCount, ticketCount * 5))
                TriggerServerEvent("bmw_autoscooter:buyTickets", ticketCount)
            else
                ESX.ShowNotification(_( 'invalid_input'))
            end
        elseif data.current.name == "abbrechen" then
            menu.close()
            ESX.ShowNotification(_( 'cancel_message'))
        end
    end, function(data,menu)
        menu.close()
    end)
end


RegisterNetEvent("bmw_autoscooter:SpawnBumper")
AddEventHandler("bmw_autoscooter:SpawnBumper", function ()
    local ModelHash = Config.SpawnName
    local time = Config.TimePerTicket
    if not IsModelInCdimage(ModelHash) then return end
    RequestModel(ModelHash)
    while not HasModelLoaded(ModelHash) do
        Wait(0)
    end
    
    local MyPed = PlayerPedId()
	local playercoords = GetEntityCoords(PlayerPedId())
	spawnedVehicle = CreateVehicle(ModelHash, Config.SpawnPoint, true, false)
    TaskWarpPedIntoVehicle(MyPed, spawnedVehicle, -1)
    SetVehicleLights(spawnedVehicle, 1)
    SetVehicleNumberPlateText(spawnedVehicle, Config.Plate)
    SetModelAsNoLongerNeeded(ModelHash)

    Citizen.Wait(time)
    DeleteVehicle(spawnedVehicle)
    ESX.ShowNotification(_( 'trip_finished'))
	
end)
