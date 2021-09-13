ESX = nil

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

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

-- Menu --
local open = false
local MenuCuisineBurgershot = RageUI.CreateMenu("Cuisine", "INTERACTION")
MenuCuisineBurgershot.Display.Header = true
MenuCuisineBurgershot.Closed = function()
    open = false
end

function OpenMenuCuisineBurgershot()
    if open then
        open = false
        RageUI.Visible(MenuCuisineBurgershot, false)
        return
    else
        open = true
        RageUI.Visible(MenuCuisineBurgershot, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(MenuCuisineBurgershot, function()
                    RageUI.Separator("↓    ~o~Préparation    ~s~↓")
                    for k, v in pairs(Config.Preparation) do
                        RageUI.Button(v.Nom, nil, {RightLabel = "~y~→"}, true, {
                            onSelected = function()
                                local playerPed = PlayerPedId()
                                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BBQ', 0, true)
                                Citizen.Wait(20000)
                                ClearPedTasksImmediately(playerPed)
                                TriggerServerEvent('dpr_Burgershot:Preparation', v.Nom, v.ItemRequis, v.ItemCuisiner)
                            end
                        })
                    end

                    RageUI.Separator("↓    ~r~Fermeture    ~s~↓")
                    RageUI.Button("~r~Fermer", nil, {RightLabel = "~y~→→"}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                        end
                    })
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
		local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'burgershot' then
			for k in pairs(Config.Position.Cuisine) do
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local pos = Config.Position.Cuisine
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

                if dist <= Config.MarkerDistance then
                    wait = 0
                    DrawMarker(Config.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
                end

                if dist <= 1.0 then
                    wait = 0
                    Visual.Subtitle(Config.TextCuisine, 1)
                    if IsControlJustPressed(1,51) then
                        OpenMenuCuisineBurgershot()
                    end
                end
		    end
        end
    Citizen.Wait(wait)
    end
end)