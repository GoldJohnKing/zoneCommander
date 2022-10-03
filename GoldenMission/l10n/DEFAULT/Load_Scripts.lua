local script_path = "C:/Users/GoldJohnKing/Saved Games/DCS.openbeta/Missions/Scripts/"

local script_list =
{
    "mist_4_5_107.lua",
    "zoneCommander.lua",
    "zoneSetup.lua",
    "Hercules_Cargo.lua",
    -- "Splash_Damage_2_0.lua",
}

local function load_scripts(path, list)
    for index, value in ipairs(list) do
        dofile(path .. value)
    end
end

if lfs then
    script_path = lfs.writedir() .. "Missions/Scripts/"

    env.info("Foothold - LFS available, using relative script load path: " .. script_path)
else
    env.info("Foothold - LFS not available, using default script load path: " .. script_path)
end

load_scripts(script_path, script_list)