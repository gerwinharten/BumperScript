if exports.es_extended:getSharedObject() then
    ESX = exports.es_extended:getSharedObject()
    print("New ESX Auto-Detected")
else
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

RegisterServerEvent("bmw_autoscooter:buyTickets")
AddEventHandler("bmw_autoscooter:buyTickets", function(ticketCount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local totalPrice = ticketCount * 5

    if xPlayer.getMoney() >= totalPrice then
        xPlayer.removeMoney(totalPrice)
        xPlayer.addInventoryItem("autoscooter_ticket", ticketCount)
        TriggerClientEvent('esx:showNotification', source, _( 'buy_ticket_success', ticketCount, totalPrice), 'success')
        TriggerClientEvent("bmw_autoscooter:SpawnBumper", source)
    else
        TriggerClientEvent('esx:showNotification', source, _('not_enough_money'), 'error')
    end
end)
