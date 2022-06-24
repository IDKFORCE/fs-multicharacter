Config = {}
Config.StartingApartment = true -- Enable/disable starting apartments (make sure to set default spawn coords)
Config.Interior = vector3(153.57, -765.12, 258.15) -- Interior to load where characters are previewed
Config.DefaultSpawn = vector3(152.73, -756.3, 258.15) -- Default spawn coords if you have start apartments disabled
Config.PedCoords = vector4(154.47, -764.7, 258.15, 118.72) -- Create preview ped at these coordinates
Config.HiddenCoords = vector4(152.73, -756.3, 258.15, 115.52) -- Hides your actual ped while you are in selection
Config.CamCoords = vector4(152.49, -765.63, 258.29, 297.9) -- Camera coordinates for character preview screen
Config.EnableDeleteButton = true -- Define if the player can delete the character or not

Config.DefaultNumberOfCharacters = 5 -- Define maximum amount of default characters (maximum 5 characters defined by default)
Config.PlayersNumberOfCharacters = { -- Define maximum amount of player characters by rockstar license (you can find this license in your server's database in the player table)
    { license = "license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", numberOfChars = 2 },
}
