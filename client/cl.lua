ESX = nil
perks = {}
perksexp = {}
Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DEL'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

local function setupESX()
    while ESX == nil do
	    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function()
    TriggerEvent("i-perks:perki")
end)

RegisterNetEvent('i-perks:perki')
AddEventHandler('i-perks:perki', function()
    ESX.TriggerServerCallback('i-perks:getskills', function (skillx,skillx2)
        perks = skillx
        perksexp = skillx2
    end)
end)
-- tylko jesli to konieczne w trakcie gry
RegisterNetEvent('i-perks:sync')
AddEventHandler('i-perks:sync', function()
end)
Citizen.CreateThread(function()
    setupESX()
    ESX.TriggerServerCallback('i-perks:getskills', function (skillx,skillx2)
        perks = skillx
        perksexp = skillx2
    end)
    while perks.driver == nil do
        Citizen.Wait(10)
    end 

    exports('GetPerk', function(zmienna)
        return tonumber(perks[zmienna]) -- 1,0
    end)
end)


RegisterCommand('-driver', function()
    vehmoc = false
end, false)

-- RegisterNetEvent('i-skills:OpenMenu')
-- AddEventHandler('i-skills:OpenMenu', function(skills)
-- 	--TriggerServerEvent('sonic_skills:LoadSkills')
-- 		local skill = perks
--         local skillexp = perksexp
-- 		ESX.UI.Menu.CloseAll()
-- 		local myItems = {
-- 			{img = "info.png", text = "INFORMACJA", text2 = "Twoje Perki, aktualny", callBack = function() end},
--     		{img = "engine.png", text = "Kierowca: "..skill.driver.." aktualny exp: "..skillexp.driverexp, text2 = "", callBack = function() if true then exports("ForceCloseMenu", ForceCloseMenu) else end  end},
-- 			{img = "drug.png", text = "Dealer: "..skill.dealer.." aktualny exp: "..skillexp.dealerexp, text2 = "", callBack = function() if true then exports("ForceCloseMenu", ForceCloseMenu) else end end},
--             {img = "drug.png", text = "Dealer: "..skill.dealer.." aktualny exp: "..skillexp.dealerexp, text2 = "", callBack = function() if true then exports("ForceCloseMenu", ForceCloseMenu) else end end},
--         }
	
-- 		local configs = {
-- 			positionX   = "90%",
-- 			positionY   = "50%"
-- 		}
	
-- 		TriggerEvent("IconMenu", myItems, configs)    
-- end)

local vehmoc = false
local pressedkey = false
RegisterCommand('+driver', function()
    vehmoc = true
    CreateThread(function()
        -- TriggerEvent("i-skills:OpenMenu")
        if IsPedSittingInAnyVehicle(PlayerPedId()) and perks.driver > 0 then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            local f1 = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveMax')
            local f2 = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveMin')
            local f3 = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fBrakeForce')
            while true do
                if vehmoc and GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                --jazda
                    if IsControlJustPressed(0, Keys['E']) and pressedkey == false then
                        --TriggerEvent('FeedM:showNotification','Włączasz dodatkowe funkcje', 500, 'bottomLeft')
                        Citizen.Wait(1000)
                        pressedkey = true
                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                        print(f3)
                        

                        SetVehicleHandlingField(vehicle, 'CHandlingData','fTractionCurveMax', f1 + f1*0.2)
                        SetVehicleHandlingField(vehicle, 'CHandlingData','fTractionCurveMin', f2 + f2*0.2)
                        SetVehicleHandlingField(vehicle, 'CHandlingData','fBrakeForce', f3 + f3*0.4)
                    end
                    if IsControlJustPressed(0, Keys['E']) and pressedkey == true then
                        --TriggerEvent('FeedM:showNotification','Wylaczasz', 500, 'bottomLeft')
                        SetVehicleHandlingField(vehicle, 'CHandlingData','fTractionCurveMax', f1)
                        SetVehicleHandlingField(vehicle, 'CHandlingData','fTractionCurveMin', f2)
                        SetVehicleHandlingField(vehicle, 'CHandlingData','fBrakeForce', f3)
                        print('stop')
                        Citizen.Wait(1000)
                        pressedkey = false
                        break
                    end
                end
                -- if (GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() and IsControlJustPressed(0, Keys['E']) and pressedkey == true) then
                --     TriggerEvent('FeedM:showNotification','Wyłączasz temat', 500, 'bottomLeft')
                --     pressedkey = false
                --     break
                -- end
                if vehmoc == false and not (GetPedInVehicleSeat(vehicle, -1) == PlayerPedId()) then
                    TriggerEvent('FeedM:showNotification','Wysiadasz z auta', 500, 'bottomLeft')
                    SetVehicleHandlingField(vehicle, 'CHandlingData','fTractionCurveMax', f1)
                    SetVehicleHandlingField(vehicle, 'CHandlingData','fTractionCurveMin', f2)
                    SetVehicleHandlingField(vehicle, 'CHandlingData','fBrakeForce', f3)
                    pressedkey = false
                    break
                end
                Citizen.Wait(1)
            end
        end
    end)
end, false)

RegisterKeyMapping('+driver', 'Driver Perk', 'keyboard', 'e')
RegisterKeyMapping('+skills', 'Driver Perk', 'keyboard', 'i')
-- RegisterCommand('+skills', function()
-- TriggerEvent("i-skills:OpenMenu")
-- end, false)