------ Thread ------

Citizen.CreateThread(function()
    local dict = "anim@mp_player_intmenu@key_fob@"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    while true do
        local car = ESX.Game.GetClosestVehicle(coords)
        local waitTime = 0

        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(car)) >= 20 then
            waitTime = 100
        else
            waitTime = 0
        end

        Citizen.Wait(waitTime)

        if IsControlJustPressed(1, 182) and waitTime == 0 then
            local plate = GetVehicleNumberPlateText(car)
            local lockStatus = GetVehicleDoorLockStatus(car)

            ESX.TriggerServerCallback('m_carlock:checkIsOwner', function(cb)
                    if cb == 'owner' then

                        if lockStatus == 0 or lockStatus == 1 then

                        SetVehicleDoorShut(car, 0, false)
                        SetVehicleDoorShut(car, 1, false)
                        SetVehicleDoorShut(car, 2, false)
                        SetVehicleDoorShut(car, 3, false)
                        SetVehicleDoorsLocked(car, 2)
                        PlayVehicleDoorCloseSound(car, 1)

                        print('You locked the vehicle! Plate: ' .. plate)

                        if not IsPedInAnyVehicle(PlayerPedId(), true) then
                            TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                        end

                        Citizen.Wait(100)
                        SetVehicleLights(car, 2)
                        Citizen.Wait(200)
                        SetVehicleLights(car, 1)
                        Citizen.Wait(200)
                        SetVehicleLights(car, 2)
                        Citizen.Wait(200)
                        SetVehicleLights(car, 1)
                        Citizen.Wait(200)
                        SetVehicleLights(car, 2)
                        Citizen.Wait(200)
                        SetVehicleLights(car, 0)

                    elseif lockStatus == 2 then

                        SetVehicleDoorsLocked(car, 1)
                        PlayVehicleDoorOpenSound(car, 0)

                        print('You unlocked the vehicle! Plate: ' .. plate)

                        if not IsPedInAnyVehicle(PlayerPedId(), true) then
                        TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                        end

                        SetVehicleLights(car, 2)
                        Citizen.Wait(100)
                        SetVehicleLights(car, 1)
                        Citizen.Wait(100)
                        SetVehicleLights(car, 2)
                        Citizen.Wait(100)
                        SetVehicleLights(car, 0)
                    end
                end
            end, plate)
        end
    end
end)