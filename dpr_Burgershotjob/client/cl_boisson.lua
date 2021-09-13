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
local MenuBoissonBurgershot = RageUI.CreateMenu("Boisson", "INTERACTION")
MenuBoissonBurgershot.Display.Header = true
MenuBoissonBurgershot.Closed = function()
    open = false
end

function OpenMenuBoissonBurgershot()
    if open then
        open = false
        RageUI.Visible(MenuBoissonBurgershot, false)
        return
    else
        open = true
        RageUI.Visible(MenuBoissonBurgershot, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(MenuBoissonBurgershot, function()
                    RageUI.Separator("↓    ~o~Boisson    ~s~↓")
                    for k, v in pairs(Config.Boisson) do
                        RageUI.Button(v.Nom, nil, {RightLabel = "~y~→"}, true, {
                            onSelected = function()
                                TriggerServerEvent('dpr_Burgershot:GiveItem', v.Nom, v.Item)
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
            for k in pairs(Config.Position.Boisson) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local pos = Config.Position.Boisson
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

                if dist <= Config.MarkerDistance then 
                    wait = 0
                    DrawMarker(Config.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
                end

                if dist <= 2.0 then 
                    wait = 0
                    Visual.Subtitle(Config.TextBoisson, 1)
                    if IsControlJustPressed(1,51) then
                        OpenMenuBoissonBurgershot()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)