ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

-- Gestion annonce
RegisterServerEvent('dpr_burgershotJob:AnnonceOuverture')
AddEventHandler('dpr_burgershotJob:AnnonceOuverture', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'burgershot', '~y~Annonce', 'Le cabinet burgershot est désormais ~g~ouvert ~s~!', 'CHAR_ESTATE_AGENT', 1)
    end
end)

RegisterServerEvent('dpr_burgershotJob:AnnonceFermeture')
AddEventHandler('dpr_burgershotJob:AnnonceFermeture', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do 
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'burgershot', '~y~Annonce', 'Le cabinet burgershot est désormais ~r~fermer ~s~!', 'CHAR_ESTATE_AGENT', 1)
    end
end)

RegisterServerEvent('dpr_burgershotJob:AnnonceRecrutement')
AddEventHandler('dpr_burgershotJob:AnnonceRecrutement', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do 
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'burgershot', '~y~Annonce', 'Le cabinet burgershot ~y~recrute ~s~rendez-vous dans nos bureau ~y~pour plus d\'information ~s~!', 'CHAR_ESTATE_AGENT', 1)
    end
end)

RegisterCommand('burgershot', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "burgershot" then
        local src = source
        local msg = rawCommand:sub(11)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'burgershot', '~y~Annonce', ''..msg..'', 'CHAR_ESTATE_AGENT', 1)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'burgershot', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_ESTATE_AGENT', 1)
    end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'burgershot', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_ESTATE_AGENT', 1)
    end
end, false)

RegisterServerEvent('dpr_burgershotJob:MessageEmployer')
AddEventHandler('dpr_burgershotJob:MessageEmployer', function(PriseOuFin, message)
    local _source = source
    local _raison = PriseOuFin
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local name = xPlayer.getName(_source)


    for i = 1, #xPlayers, 1 do
        local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
        if thePlayer.job.name == 'burgershot' then
            TriggerClientEvent('dpr_burgershotJob:MessageEmployer', xPlayers[i], _raison, name, message)
        end
    end
end)

-- Coffre
RegisterServerEvent('dpr_burgershotJob:prendreitems')
AddEventHandler('dpr_burgershotJob:prendreitems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_burgershot', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then

			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)
			end
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)


RegisterNetEvent('dpr_burgershotJob:stockitem')
AddEventHandler('dpr_burgershotJob:stockitem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_burgershot', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', _source, "Objet déposé "..count..""..inventoryItem.label.."")
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)


ESX.RegisterServerCallback('dpr_burgershotJob:inventairejoueur', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('dpr_burgershotJob:prendreitem', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_burgershot', function(inventory)
		cb(inventory.items)
	end)
end)

-- Preparation
RegisterNetEvent('dpr_Burgershot:Preparation')
AddEventHandler('dpr_Burgershot:Preparation', function(Nom, ItemRequis, ItemCuisiner)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local ItemBesoin = xPlayer.getInventoryItem(ItemRequis).count
    local ItemDonner = xPlayer.getInventoryItem(ItemCuisiner).count

    if ItemDonner > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Tu à ateint la limite')
    elseif ItemBesoin < 1 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il vous manques des ingredients')
    else
        xPlayer.removeInventoryItem(ItemRequis, 1)
        xPlayer.addInventoryItem(ItemCuisiner, 1)    
    end
end)

-- Stock
RegisterNetEvent('dpr_Burgershot:GiveItem')
AddEventHandler('dpr_Burgershot:GiveItem', function(Nom, Item)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    xPlayer.addInventoryItem(Item, 1)
end)