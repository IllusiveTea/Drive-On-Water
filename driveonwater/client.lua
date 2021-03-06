local toggle = false 
local drivew = false
RegisterCommand("driveonwater", function(source, args, rawCommand)
    toggle = not toggle
    if toggle then
        drivew = true
        TriggerEvent("chatMessage", "", {255,255,255}, "Drive On Water: ^2^*Enabled")

    else
        drivew = false
        TriggerEvent("chatMessage", "", {255,255,255}, "Drive On Water: ^8^*Disabled")
    end
end,false)

local toggle2 = false 
local walkw = false
RegisterCommand("waterwalk", function(source, args, rawCommand)
    toggle2 = not toggle2
    if toggle2 then
        walkw = true
        TriggerEvent("chatMessage", "", {255,255,255}, "Walk On Water: ^2^*Enabled")

    else
        walkw = false
        TriggerEvent("chatMessage", "", {255,255,255}, "Walk On Water: ^8^*Disabled")
    end
end,false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local x, y, z = table.unpack(GetEntityCoords(GetVehiclePedIsUsing(PlayerPedId()), true))
        gotheight, height = GetWaterHeight(x, y, z, z)
        if IsPedInAnyVehicle(PlayerPedId(), true) and gotheight and drivew then
            hed = GetEntityHeading(GetVehiclePedIsUsing(PlayerPedId()))
            local object = CreateObject(GetHashKey("prop_lev_des_barge_01"), x, y, height-4.0, true, false, false)
            SetEntityAlpha(object, 0, true)
            SetEntityDynamic(object, false)
            SetEntityRotation(object, 0.0, 180.0, -hed, 1, true)
            Citizen.Wait(35)
            DeleteEntity(object)    
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
        gotheight, height = GetWaterHeight(x, y, z, z)
        if IsPedOnFoot(PlayerPedId()) and gotheight and walkw then
            hed = GetEntityHeading(PlayerPedId())
            local object = CreateObject(GetHashKey("prop_lev_des_barge_01"), x, y, height-4.0, true, false, false)
            SetEntityAlpha(object, 0, true)
            SetEntityDynamic(object, false)
            SetEntityRotation(object, 0.0, 180.0, -hed, 1, true)
            Citizen.Wait(100)
            DeleteEntity(object)    
        end
    end
end)
