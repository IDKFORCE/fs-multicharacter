# fs-multicharacter

Just An Edit Version Of The Latest qb-multicharacter

if your using (qb-clothing) go to line 166 fs-multicharacter/client and take the two dash -- out
if your using (fivem-appearance) the export is in line 167 In fs-multicharacter/client and is already set up


## Dependencies
- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-spawn](https://github.com/qbcore-framework/qb-spawn) - Spawn selector make sure you guys are in the latest
- [qb-apartments](https://github.com/qbcore-framework/qb-apartments) - For giving the player a apartment after creating a character. make sure you guys are in the latest
- [qb-clothing](https://github.com/qbcore-framework/qb-clothing) - this is for the people using (qb-clothing) make sure you guys are in the latest
- [fivem-appearance](https://github.com/iLLeniumStudios/fivem-appearance) - this is for the people using (fivem-appearance) make sure you guys are in the latest
- [qb-weathersync](https://github.com/qbcore-framework/qb-weathersync) - For adjusting the weather while player is creating a character.  make sure you guys are in the latest

## Screenshots
![Character List](https://cdn.discordapp.com/attachments/784243374269661195/989954216263028816/unknown.png)
![Character Selection](https://cdn.discordapp.com/attachments/784243374269661195/989954313327628298/unknown.png)
![Character Registration](https://cdn.discordapp.com/attachments/784243374269661195/989954437189623888/unknown.png)
![Delete Character](https://cdn.discordapp.com/attachments/784243374269661195/989954509377794128/unknown.png)


## ManualInstallation

- Download the script and put it in the `[qb]` directory.

- Add the following code to your server.cfg/resouces.cfg
```
ensure qb-core
ensure fs-multicharacter
ensure qb-spawn
ensure qb-apartments
ensure qb-clothing
ensure qb-weathersync
```
## Replace the qb-multicharacter:server:getSkin callback on Line: 171 of qb-multicharacter/server/main.lua with:

```QBCore.Functions.CreateCallback("qb-multicharacter:server:getSkin", function(_, cb, cid)
    local result = MySQL.query.await('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', {cid, 1})
    if result[1] ~= nil then
        cb(json.decode(result[1].skin))
    else
        cb(nil)
    end
end)```

## Replace the RegisterNUICallback('cDataPed', function(nData, cb) callback on Line: 118 of qb-multicharacter/client/main.lua with:

```RegisterNUICallback('cDataPed', function(nData, cb)
    local cData = nData.cData
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)
    if cData ~= nil then
        QBCore.Functions.TriggerCallback('qb-multicharacter:server:getSkin', function(skinData)
            if skinData then
                local model = skinData.model
                CreateThread(function()
                    RequestModel(GetHashKey(model))
                    while not HasModelLoaded(GetHashKey(model)) do
                        Wait(10)
                    end
                    charPed = CreatePed(2, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 0.98, Config.PedCoords.w, false, true)
                    SetPedComponentVariation(charPed, 0, 0, 0, 2)
                    FreezeEntityPosition(charPed, false)
                    SetEntityInvincible(charPed, true)
                    PlaceObjectOnGroundProperly(charPed)
                    SetBlockingOfNonTemporaryEvents(charPed, true)
                    exports['fivem-appearance']:setPedAppearance(charPed, skinData)
                end)
            else
                CreateThread(function()
                    local randommodels = {
                        "mp_m_freemode_01",
                        "mp_f_freemode_01",
                    }
                    local model = GetHashKey(randommodels[math.random(1, #randommodels)])
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Wait(10)
                    end
                    charPed = CreatePed(2, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 0.98, Config.PedCoords.w, false, true)
                    SetPedComponentVariation(charPed, 0, 0, 0, 2)
                    FreezeEntityPosition(charPed, false)
                    SetEntityInvincible(charPed, true)
                    PlaceObjectOnGroundProperly(charPed)
                    SetBlockingOfNonTemporaryEvents(charPed, true)
                end)
            end
            cb("ok")
        end, cData.citizenid)
    else
        CreateThread(function()
            local randommodels = {
                "mp_m_freemode_01",
                "mp_f_freemode_01",
            }
            local model = GetHashKey(randommodels[math.random(1, #randommodels)])
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end
            charPed = CreatePed(2, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 0.98, Config.PedCoords.w, false, true)
            SetPedComponentVariation(charPed, 0, 0, 0, 2)
            FreezeEntityPosition(charPed, false)
            SetEntityInvincible(charPed, true)
            PlaceObjectOnGroundProperly(charPed)
            SetBlockingOfNonTemporaryEvents(charPed, true)
        end)
        cb("ok")
    end
end)```
