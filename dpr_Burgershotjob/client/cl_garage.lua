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
local MenuGarageBurgershot = RageUI.CreateMenu("Garage", "INTERACTION")
MenuGarageBurgershot.Display.Header = true
MenuGarageBurgershot.Closed = function()
    open = false
end

function OpenMenuGarageBurgershot()
    if open then
        open = false
        RageUI.Visible(MenuGarageBurgershot, false)
        return
    else
        open = true
        RageUI.Visible(MenuGarageBurgershot, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(MenuGarageBurgershot, function()
                    RageUI.Separator("↓    ~o~Ranger    ~s~↓")
                    RageUI.Button("Ranger le véhicule", nil, {RightLabel = "~y~→→→"}, true, {
                        onSelected = function()
                            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                            if dist4 < 4 then
                                DeleteEntity(veh)
                                ESX.ShowAdvancedNotification("Burgershot", "~y~Garage", "Le véhicule à bien été ranger !", "CHAR_ESTATE_AGENT", 1)
                                RageUI.CloseAll()
                            end
                        end
                    })
                    RageUI.Separator("↓     ~o~Véhicule     ~s~↓")
                    for k,v in pairs(Config.Vehicule) do 
                        RageUI.Button(v.Nom, nil, {RightLabel = "~y~→"}, true, {
                            onSelected = function()
                                Citizen.Wait(3000) -- Temps de spawn 1000 = 1 seconde
                                local car = GetHashKey(v.Spawn)
                                local retval = PlayerPedId()

                                RequestModel(car)
                                while not HasModelLoaded(car) do
                                    RequestModel(car)
                                    Citizen.Wait(0)
                                end
                                
                                local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
                                local vehicle = CreateVehicle(car, -1168.73, -883.5, 14.11, 124.37, true, false)
                                SetEntityAsMissionEntity(vehicle, true, true)
                                local plaque = "Burgershot"
                                SetVehicleNumberPlateText(vehicle, plaque) 
                                TriggerServerEvent('ddx_vehiclelock:givekey', 'no', GetVehicleNumberPlateText(vehicle))
                            end
                        })
                    end
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
            for k in pairs(Config.Position.Garage) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local pos = Config.Position.Garage
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

                if dist <= 5.0 then 
                    wait = 0
                    DrawMarker(Config.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
                end

                if dist <= 2.0 then 
                    wait = 0
                    Visual.Subtitle(Config.TextGarage, 1)
                    if IsControlJustPressed(1,51) then
                        OpenMenuGarageBurgershot()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)
