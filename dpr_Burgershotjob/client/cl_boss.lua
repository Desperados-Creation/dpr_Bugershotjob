ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- MENU FUNCTION --
local open = false 
local MenuBossBurgershot = RageUI.CreateMenu('Boss Action', 'interaction')
MenuBossBurgershot.Display.Header = true 
MenuBossBurgershot.Closed = function()
  open = false
end

function OpenMenuBossburgershot()
	if open then 
		open = false
		RageUI.Visible(MenuBossBurgershot, false)
		return
	else
		open = true 
		RageUI.Visible(MenuBossBurgershot, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(MenuBossBurgershot,function()
                RageUI.Separator("↓     ~y~Gestion de l'entreprise     ~s~↓")
                RageUI.Button("Retirer argent de société", nil, {RightLabel = "~y~→→"}, true , {
                    onSelected = function()
                        local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'burgershot', amount)
                            end
                    end
                })

                RageUI.Button("Déposer argent de société", nil, {RightLabel = "~y~→→"}, true , {
                    onSelected = function()
                        local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:depositMoney', 'burgershot', amount)
                            end
                    end
                })

                RageUI.Button("Gestion Entreprise", nil, {RightLabel = "~y~→→→"}, true , {
                    onSelected = function()
                        aboss()
                        RageUI.CloseAll()
                    end
                })
                end)
		    Wait(0)
		    end
	    end)
    end
end

function aboss()
    TriggerEvent('esx_society:openBossMenu', 'burgershot', function(data, menu)
        menu.close()
    end, {wash = false})
end

Citizen.CreateThread(function()
    while true do
        local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'burgershot' and ESX.PlayerData.job.grade_name == 'boss' then
            for k in pairs(Config.Position.Boss) do
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local pos = Config.Position.Boss
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

                if dist <= Config.MarkerDistance then
                    wait = 0
                    DrawMarker(Config.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
                end

                if dist <= 1.0 then
                    wait = 0
                    Visual.Subtitle(Config.TextBoss, 1)
                    if IsControlJustPressed(1,51) then
                        OpenMenuBossburgershot()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)
