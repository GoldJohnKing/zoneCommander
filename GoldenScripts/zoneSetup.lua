-- BattleCommander Initialization

local filepath = 'Caucasus-S-Saved-Data.lua'
if lfs then
	local dir = lfs.writedir()..'Missions/Saves/'
	lfs.mkdir(dir)
	filepath = dir..filepath
	env.info('Foothold - Save file path: '..filepath)
end

-- Difficulty scaling
-- <start> is the base value, all calculation is added onto this
-- overall minimum <difficultyModifier> = <start> + <min>
-- overall maximum <difficultyModifier> = <start> + <max>
-- once a <coalition>'s zone becomes neutral, its <difficultyModifier> increases <escalation>
-- once <coalition> captures a zone, its <difficultyModifier> decreases <escalation>
-- if every <difficultyModifier> hasn't been changed for <fadeTime> seconds, <difficultyModifier> will decreases <fade>
local difficulty = { start = 1, min = 0, max = 7, escalation = 1, fade = 0.001, fadeTime = 30, coalition = 1 }
bc = BattleCommander:new(filepath, 30, 30, difficulty) -- This MUST be global, as zoneCommander.lua gets zone list though it for support menu to work

-- BattleCommander Initialization Done

-- Zone Definition

local hint = "任务目标：占领所有区域！"

local blueUpgrades =
{
	normal = { "bInfantry", "bArmor", "bSamIR", "bSamIR", "bSam" },
	airfield = { "bInfantry", "bArmor", "bSamIR", "bSam", "bSam2" },
}

local zoneUpgrades = {
	normal = {
		blue = blueUpgrades.normal,
		red = { "r-defense-motor", "r-defense-mech", "r-defense-sam-ir", "r-defense-sam-radar-close", "r-defense-sam-radar-medium" }
	},
	sam = {
		blue = blueUpgrades.normal,
		red = { "r-defense-sam-ir", "r-defense-sam-cram", "r-defense-sam-radar-close", "r-defense-sam-radar-medium", "r-defense-sam-radar-far" }
	},
	airfield = {
		blue = blueUpgrades.airfield,
		red = { "r-defense-mech", "r-defense-sam-ir", "r-defense-sam-radar-close", "r-defense-sam-radar-medium", "r-defense-sam-radar-medium" }
	},
	airfieldPlus = {
		blue = blueUpgrades.airfield,
		red = { "r-defense-sam-ir", "r-defense-sam-radar-close", "r-defense-sam-radar-close", "r-defense-sam-radar-medium", "r-defense-sam-radar-medium" }
	},
	airfieldUltra = {
		blue = blueUpgrades.airfield,
		red = { "r-defense-sam-cram", "r-defense-sam-radar-close", "r-defense-sam-radar-medium", "r-defense-sam-radar-medium", "r-defense-sam-radar-far" }
	},
	port = {
		blue = blueUpgrades.normal,
		red = { "r-defense-mech", "r-defense-sam-ir", "r-defense-sam-radar-close", "r-defense-sam-radar-medium", "r-ship" }
	},
}

local zones = {
	sochi = {
		zoneCommanderProperties = {
			zone = "Sochi",
			side = 2, -- 0 = neutral, 1 = red, 2 = blue
			level = 5,
			upgrades = zoneUpgrades.airfield,
			flavorText = hint,
			income = 1,
		},
		dispatches = {
			-- mission: "patrol", "supply", "attack"
			-- type: "air", "carrier_air", "surface"
			{ name = "b-attack-sochi-gudauta-av8b", mission = "attack", targetzone = "Gudauta", type = "air" },

			{ name = "b-patrol-sochi-sochi-f18c", mission = "patrol", targetzone = "Sochi" },

			{ name = "b-supply-sochi-gudauta-uh60a", mission = "supply", targetzone = "Gudauta" },
			{ name = "b-supply-sochi-alpha-uh60a", mission = "supply", targetzone = "Alpha" },
		},
		criticalObjects = {},
		connections = {
			"Alpha",
		},
	},

	alpha = {
		zoneCommanderProperties = {
			zone = "Alpha",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.normal,
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {
			"Gudauta",
		},
	},

	gudauta = {
		zoneCommanderProperties = {
			zone = "Gudauta",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.airfield,
			flavorText = hint,
			income = 1,
		},
		dispatches = {
			{ name = "r-attack-gudauta-sochi-f16c", mission = "attack", targetzone = "Sochi" },

			{ name = "r-attack-gudauta-alpha-ka50_3", mission = "attack", targetzone = "Alpha" },

			{ name = "r-attack-gudauta-alpha-armor", mission = "attack", targetzone = "Alpha", type = "surface" },

			{ name = "r-supply-gudauta-alpha-mi24p", mission = "supply", targetzone = "Alpha" },
			{ name = "r-supply-gudauta-bravo-mi24p", mission = "supply", targetzone = "Bravo" },
			{ name = "r-supply-gudauta-sukhumi-mi24p", mission = "supply", targetzone = "Sukhumi" },

			{ name = "r-supply-gudauta-alpha-armor", mission = "supply", targetzone = "Alpha", type = "surface" },

			{ name = "r-patrol-gudauta-gudauta-f18c", mission = "patrol", targetzone = "Gudauta" },

			{ name = "b-attack-gudauta-sukhumi-a10c2", mission = "attack", targetzone = "Sukhumi" },

			{ name = "b-supply-gudauta-sochi-uh60a", mission = "supply", targetzone = "Sochi" },
			{ name = "b-supply-gudauta-alpha-uh60a", mission = "supply", targetzone = "Alpha" },
			{ name = "b-supply-gudauta-bravo-uh60a", mission = "supply", targetzone = "Bravo" },
			{ name = "b-supply-gudauta-sukhumi-uh60a", mission = "supply", targetzone = "Sukhumi" },
		},
		criticalObjects = {},
		connections = {
			"Bravo",
		},
	},

	bravo = {
		zoneCommanderProperties = {
			zone = "Bravo",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.normal,
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {
			"Sukhumi",
			"Radio",
		},
	},

	sukhumi = {
		zoneCommanderProperties = {
			zone = "Sukhumi",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.airfield,
			flavorText = hint,
			income = 1,
		},
		dispatches = {
			{ name = "r-attack-sukhumi-gudauta-su25t", mission = "attack", targetzone = "Gudauta" },
			{ name = "r-attack-sukhumi-sochi-a10c2", mission = "attack", targetzone = "Sochi" },

			{ name = "r-attack-sukhumi-bravo-ah64d", mission = "attack", targetzone = "Bravo" },

			{ name = "r-attack-sukhumi-bravo-armor", mission = "attack", targetzone = "Bravo", type = "surface" },

			{ name = "r-patrol-sukhumi-sukhumi-j11a", mission = "patrol", targetzone = "Sukhumi" },
			{ name = "r-patrol-sukhumi-gudauta-f15c", mission = "patrol", targetzone = "Gudauta" },

			{ name = "r-supply-sukhumi-gudauta-mi24p", mission = "supply", targetzone = "Gudauta" },
			{ name = "r-supply-sukhumi-bravo-mi24p", mission = "supply", targetzone = "Bravo" },
			{ name = "r-supply-sukhumi-radio-mi24p", mission = "supply", targetzone = "Radio" },
			{ name = "r-supply-sukhumi-charlie-mi24p", mission = "supply", targetzone = "Charlie" },
			{ name = "r-supply-sukhumi-alpha-mi8", mission = "supply", targetzone = "Alpha" },
			{ name = "r-supply-sukhumi-delta-mi8", mission = "supply", targetzone = "Delta" },
			{ name = "r-supply-sukhumi-senaki-mi8", mission = "supply", targetzone = "Senaki" },
			{ name = "r-supply-sukhumi-port-mi8", mission = "supply", targetzone = "Port" },
			{ name = "r-supply-sukhumi-batumi-mi8", mission = "supply", targetzone = "Batumi" },

			{ name = "r-supply-sukhumi-bravo-armor", mission = "supply", targetzone = "Bravo", type = "surface" },

			{ name = "b-attack-sukhumi-senaki-f16c", mission = "attack", targetzone = "Senaki" },

			{ name = "b-supply-sukhumi-gudauta-uh60a", mission = "supply", targetzone = "Gudauta" },
			{ name = "b-supply-sukhumi-bravo-uh60a", mission = "supply", targetzone = "Bravo" },
			{ name = "b-supply-sukhumi-radio-uh60a", mission = "supply", targetzone = "Radio" },
			{ name = "b-supply-sukhumi-charlie-uh60a", mission = "supply", targetzone = "Charlie" },
			{ name = "b-supply-sukhumi-delta-uh60a", mission = "supply", targetzone = "Delta" },
			{ name = "b-supply-sukhumi-senaki-uh60a", mission = "supply", targetzone = "Senaki" },
			{ name = "b-supply-sukhumi-port-uh60a", mission = "supply", targetzone = "Port" },
			{ name = "b-supply-sukhumi-batumi-uh60a", mission = "supply", targetzone = "Batumi" },
		},
		criticalObjects = {},
		connections = {
			"Radio",
			"Charlie",
		},
	},

	radio = {
		zoneCommanderProperties = {
			zone = "Radio",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.airfield,
			flavorText = hint,
			income = 1,
		},
		dispatches = {},
		criticalObjects = {
			-- "critical-object-radio-1",
		},
		connections = {
			"Charlie",
			"Delta",
		},
	},

	charlie = {
		zoneCommanderProperties = {
			zone = "Charlie",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.normal,
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {
			"Delta",
			"Senaki",
			"Port",
		},
	},

	delta = {
		zoneCommanderProperties = {
			zone = "Delta",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.normal,
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {
			"SAM",
			"Senaki",
		},
	},

	port = {
		zoneCommanderProperties = {
			zone = "Port",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.port,
			flavorText = hint,
			income = 1,
		},
		dispatches = {
			{ name = "r-attack-port-charlie-armor", mission = "attack", targetzone = "Charlie", type = "surface" },
			{ name = "r-attack-port-senaki-armor", mission = "attack", targetzone = "Senaki", type = "surface" },
			{ name = "r-attack-port-kobuleti-armor", mission = "attack", targetzone = "Kobuleti", type = "surface" },

			{ name = "r-supply-port-charlie-armor", mission = "supply", targetzone = "Charlie", type = "surface" },
			{ name = "r-supply-port-senaki-armor", mission = "supply", targetzone = "Senaki", type = "surface" },
			{ name = "r-supply-port-kobuleti-armor", mission = "supply", targetzone = "Kobuleti", type = "surface" },
		},
		criticalObjects = {
			-- "critical-object-port-1",
		},
		connections = {
			"Senaki",
			"Kobuleti",
			"Batumi",
		},
	},

	senaki = {
		zoneCommanderProperties = {
			zone = "Senaki",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.airfieldPlus,
			flavorText = hint,
			income = 3,
		},
		dispatches = {
			{ name = "r-attack-senaki-sukhumi-su34", mission = "attack", targetzone = "Sukhumi" },

			{ name = "r-attack-senaki-delta-ka50_3", mission = "attack", targetzone = "Delta" },
			{ name = "r-attack-senaki-port-ah64d", mission = "attack", targetzone = "Port" },
			{ name = "r-attack-senaki-oil-ah64d", mission = "attack", targetzone = "Oil" },
			{ name = "r-attack-senaki-charlie-ka50_3", mission = "attack", targetzone = "Charlie" },
			{ name = "r-attack-senaki-sam-ah1w", mission = "attack", targetzone = "SAM" },
			{ name = "r-attack-senaki-kobuleti-ah1w", mission = "attack", targetzone = "Kobuleti" },

			{ name = "r-attack-senaki-port-armor", mission = "attack", targetzone = "Port", type = "surface" },

			{ name = "r-patrol-senaki-sukhumi-f16c", mission = "patrol", targetzone = "Sukhumi" },
			{ name = "r-patrol-senaki-kutaisi-j11a", mission = "patrol", targetzone = "Kutaisi" },
			{ name = "r-patrol-senaki-batumi-f15c", mission = "patrol", targetzone = "Batumi" },

			{ name = "r-supply-senaki-charlie-mi24p", mission = "supply", targetzone = "Charlie" },
			{ name = "r-supply-senaki-delta-mi24p", mission = "supply", targetzone = "Delta" },
			{ name = "r-supply-senaki-sam-mi24p", mission = "supply", targetzone = "SAM" },
			{ name = "r-supply-senaki-kutaisi-mi24p", mission = "supply", targetzone = "Kutaisi" },
			{ name = "r-supply-senaki-oil-mi24p", mission = "supply", targetzone = "Oil" },
			{ name = "r-supply-senaki-kobuleti-mi24p", mission = "supply", targetzone = "Kobuleti" },
			{ name = "r-supply-senaki-port-mi24p", mission = "supply", targetzone = "Port" },
			{ name = "r-supply-senaki-sukhumi-mi8", mission = "supply", targetzone = "Sukhumi" },
			{ name = "r-supply-senaki-radio-mi8", mission = "supply", targetzone = "Radio" },
			{ name = "r-supply-senaki-echo-mi8", mission = "supply", targetzone = "Echo" },

			{ name = "r-supply-senaki-port-armor", mission = "supply", targetzone = "Port", type = "surface" },

			{ name = "b-supply-senaki-charlie-uh60a", mission = "supply", targetzone = "Charlie" },
			{ name = "b-supply-senaki-sukhumi-uh60a", mission = "supply", targetzone = "Sukhumi" },
			{ name = "b-supply-senaki-radio-uh60a", mission = "supply", targetzone = "Radio" },
			{ name = "b-supply-senaki-delta-uh60a", mission = "supply", targetzone = "Delta" },
			{ name = "b-supply-senaki-port-uh60a", mission = "supply", targetzone = "Port" },
			{ name = "b-supply-senaki-sam-uh60a", mission = "supply", targetzone = "SAM" },
			{ name = "b-supply-senaki-kutaisi-uh60a", mission = "supply", targetzone = "Kutaisi" },
			{ name = "b-supply-senaki-oil-uh60a", mission = "supply", targetzone = "Oil" },
			{ name = "b-supply-senaki-kobuleti-uh60a", mission = "supply", targetzone = "Kobuleti" },
			{ name = "b-supply-senaki-echo-uh60a", mission = "supply", targetzone = "Echo" },
		},
		criticalObjects = {},
		connections = {
			"SAM",
			"Kutaisi",
			"Oil",
			"Kobuleti",
		},
	},

	sam = {
		zoneCommanderProperties = {
			zone = "SAM",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.sam,
			flavorText = hint,
			income = 1,
		},
		dispatches = {},
		criticalObjects = {
			-- "critical-object-sam-1",
		},
		connections = {
			"Echo",
			"Kutaisi",
		},
	},

	kobuleti = {
		zoneCommanderProperties = {
			zone = "Kobuleti",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.airfieldPlus,
			flavorText = hint,
			income = 3,
		},
		dispatches = {
			{ name = "r-attack-kobuleti-senaki-f16c", mission = "attack", targetzone = "Senaki" },
			{ name = "r-attack-kobuleti-kutaisi-f18c", mission = "attack", targetzone = "Kutaisi" },
			{ name = "r-attack-kobuleti-batumi-a10c2", mission = "attack", targetzone = "Batumi" },

			{ name = "r-attack-kobuleti-port-ah64d", mission = "attack", targetzone = "Port" },
			{ name = "r-attack-kobuleti-oil-ah64d", mission = "attack", targetzone = "Oil" },
			{ name = "r-attack-kobuleti-batumi-ah1w", mission = "attack", targetzone = "Batumi" },
			{ name = "r-attack-kobuleti-senaki-ka50_3", mission = "attack", targetzone = "Senaki" },

			{ name = "r-patrol-kobuleti-kobuleti-m2000c", mission = "patrol", targetzone = "Kobuleti" },
			{ name = "r-patrol-kobuleti-sukhumi-f15e", mission = "patrol", targetzone = "Sukhumi" },

			{ name = "r-supply-kobuleti-senaki-mi24p", mission = "supply", targetzone = "Senaki" },
			{ name = "r-supply-kobuleti-port-mi24p", mission = "supply", targetzone = "Port" },
			{ name = "r-supply-kobuleti-oil-mi24p", mission = "supply", targetzone = "Oil" },
			{ name = "r-supply-kobuleti-kutaisi-mi8", mission = "supply", targetzone = "Kutaisi" },

			{ name = "b-supply-kobuleti-senaki-uh60a", mission = "supply", targetzone = "Senaki" },
			{ name = "b-supply-kobuleti-port-uh60a", mission = "supply", targetzone = "Port" },
			{ name = "b-supply-kobuleti-oil-uh60a", mission = "supply", targetzone = "Oil" },
			{ name = "b-supply-kobuleti-kutaisi-uh60a", mission = "supply", targetzone = "Kutaisi" },
		},
		criticalObjects = {},
		connections = {
			"Oil",
			"Batumi",
		},
	},

	oil = {
		zoneCommanderProperties = {
			zone = "Oil",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.airfield,
			flavorText = hint,
			income = 1,
		},
		dispatches = {},
		criticalObjects = {
			-- "critical-object-oil-1",
		},
		connections = {
			"Kutaisi",
			"Batumi",
		},
	},

	kutaisi = {
		zoneCommanderProperties = {
			zone = "Kutaisi",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.airfieldPlus,
			flavorText = hint,
			income = 3,
		},
		dispatches = {
			{ name = "r-attack-kutaisi-senaki-ajs37", mission = "attack", targetzone = "Senaki" },
			{ name = "r-attack-kutaisi-port-f16c", mission = "attack", targetzone = "Port" },
			{ name = "r-attack-kutaisi-kobuleti-su25t", mission = "attack", targetzone = "Kobuleti" },
			{ name = "r-attack-kutaisi-sam-a10c2", mission = "attack", targetzone = "SAM" },

			{ name = "r-attack-kutaisi-oil-ka50_3", mission = "attack", targetzone = "Oil" },
			{ name = "r-attack-kutaisi-sam-ah1w", mission = "attack", targetzone = "SAM" },
			{ name = "r-attack-kutaisi-senaki-ah64d", mission = "attack", targetzone = "Senaki" },

			{ name = "r-attack-kutaisi-sam-armor", mission = "attack", targetzone = "SAM", type = "surface" },

			{ name = "r-patrol-kutaisi-kutaisi-jf17", mission = "patrol", targetzone = "Kutaisi" },

			{ name = "r-supply-kutaisi-echo-mi24p", mission = "supply", targetzone = "Echo" },
			{ name = "r-supply-kutaisi-oil-mi24p", mission = "supply", targetzone = "Oil" },
			{ name = "r-supply-kutaisi-sam-mi24p", mission = "supply", targetzone = "SAM" },
			{ name = "r-supply-kutaisi-senaki-mi24p", mission = "supply", targetzone = "Senaki" },
			{ name = "r-supply-kutaisi-batumi-mi8", mission = "supply", targetzone = "Batumi" },
			{ name = "r-supply-kutaisi-kobuleti-mi8", mission = "supply", targetzone = "Kobuleti" },
			{ name = "r-supply-kutaisi-port-mi8", mission = "supply", targetzone = "Port" },
			{ name = "r-supply-kutaisi-delta-mi8", mission = "supply", targetzone = "Delta" },

			{ name = "r-supply-kutaisi-sam-armor", mission = "supply", targetzone = "SAM", type = "surface" },

			{ name = "b-supply-kutaisi-echo-uh60a", mission = "supply", targetzone = "Echo" },
			{ name = "b-supply-kutaisi-oil-uh60a", mission = "supply", targetzone = "Oil" },
			{ name = "b-supply-kutaisi-kobuleti-uh60a", mission = "supply", targetzone = "Kobuleti" },
			{ name = "b-supply-kutaisi-batumi-uh60a", mission = "supply", targetzone = "Batumi" },
			{ name = "b-supply-kutaisi-port-uh60a", mission = "supply", targetzone = "Port" },
			{ name = "b-supply-kutaisi-sam-uh60a", mission = "supply", targetzone = "SAM" },
			{ name = "b-supply-kutaisi-senaki-uh60a", mission = "supply", targetzone = "Senaki" },
			{ name = "b-supply-kutaisi-delta-uh60a", mission = "supply", targetzone = "Delta" },
		},
		criticalObjects = {},
		connections = {
			"Echo",
		},
	},

	echo = {
		zoneCommanderProperties = {
			zone = "Echo",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.normal,
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {
		},
	},

	batumi = {
		zoneCommanderProperties = {
			zone = "Batumi",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.airfieldUltra,
			flavorText = hint,
			income = 3,
		},
		dispatches = {
			{ name = "r-attack-batumi-kobuleti-su34", mission = "attack", targetzone = "Kobuleti" },

			{ name = "r-attack-batumi-kobuleti-ka50_3", mission = "attack", targetzone = "Kobuleti" },

			{ name = "r-patrol-batumi-batumi-mig29s", mission = "patrol", targetzone = "Batumi" },

			{ name = "r-supply-batumi-kobuleti-mi24p", mission = "supply", targetzone = "Kobuleti" },
			{ name = "r-supply-batumi-port-mi24p", mission = "supply", targetzone = "Port" },
			{ name = "r-supply-batumi-oil-mi8", mission = "supply", targetzone = "Oil" },

			{ name = "b-supply-batumi-kobuleti-uh60a", mission = "supply", targetzone = "Kobuleti" },
			{ name = "b-supply-batumi-port-uh60a", mission = "supply", targetzone = "Port" },
			{ name = "b-supply-batumi-oil-uh60a", mission = "supply", targetzone = "Oil" },
		},
		criticalObjects = {},
		connections = {
		},
	},
}

-- Zone Definition Done

-- Zone Initialization

local function NewZone(zone)
	zone.zoneCommander = ZoneCommander:new(zone.zoneCommanderProperties)

	local dispatches = {}
	for key, value in pairs(zone.dispatches) do
		table.insert(dispatches, GroupCommander:new(value))
	end

	zone.zoneCommander:addGroups(dispatches)

	for key, value in pairs(zone.criticalObjects) do
		zone.zoneCommander:addCriticalObject(value)
	end

	bc:addZone(zone.zoneCommander)

	for key, value in pairs(zone.connections) do
		bc:addConnection(zone.zoneCommanderProperties.zone, value)
	end
end

local function InitZones()
	for key, value in pairs(zones) do
		NewZone(value)
	end
end

InitZones()

-- Zone Initialization Done

-- Blue Support

local seadTargetMenu = nil
bc:registerShopItem('sead', 'F/A-18C 防空压制任务', 1500, function(sender)
	local gr = Group.getByName('sead1')
	if Utils.isGroupActive(gr) then
		return '防空压制任务仍在进行中'
	end
	mist.respawnGroup('sead1', true)

	if seadTargetMenu then
		return '请使用 F10 菜单指派攻击目标'
	end

	local launchAttack = function(target)
		if Group.getByName('sead1') then
			local err = bc:engageZone(target, 'sead1')
			if err then
				return err
			end

			trigger.action.outTextForCoalition(2, 'F/A-18C 正在对' .. target .. '战区进行防空压制', 60)
		else
			trigger.action.outTextForCoalition(2, '支援单位已离开战区或已被击毁', 60)
		end

		seadTargetMenu = nil
	end

	seadTargetMenu = bc:showTargetZoneMenu(2, '指派 F/A-18C 防空压制目标', launchAttack, 1)

	trigger.action.outTextForCoalition(2, 'F/A-18C 已就绪，请使用 F10 菜单指派攻击目标', 60)
end,
	function(sender, params)
		if params.zone and params.zone.side == 1 then
			local gr = Group.getByName('sead1')
			if Utils.isGroupActive(gr) then
				return '防空压制任务仍在进行中'
			end

			mist.respawnGroup('sead1', true)
			mist.scheduleFunction(function(target)
				if Group.getByName('sead1') then
					local err = bc:engageZone(target, 'sead1')
					if err then
						return err
					end

					trigger.action.outTextForCoalition(2, 'F/A-18C 正在对' .. target .. '战区进行防空压制', 60)
				end
			end, { params.zone.zone }, timer.getTime() + 2)
		else
			return '仅允许攻击敌方占领区'
		end
	end)

bc:registerShopItem('sweep', 'F-14B 战斗机扫荡任务', 1500, function(sender)
	local gr = Group.getByName('sweep1')
	if Utils.isGroupActive(gr) then
		return '战斗机扫荡任务仍在进行中'
	end
	mist.respawnGroup('sweep1', true)
end,
	function(sender, params)
		local gr = Group.getByName('sweep1')
		if Utils.isGroupActive(gr) then
			return '战斗机扫荡任务仍在进行中'
		end
		mist.respawnGroup('sweep1', true)
	end)

local casTargetMenu = nil
bc:registerShopItem('cas', 'F-16CM 对地攻击任务', 1500, function(sender)
	local gr = Group.getByName('cas1')
	if Utils.isGroupActive(gr) then
		return '对地攻击任务仍在进行中'
	end

	mist.respawnGroup('cas1', true)

	if casTargetMenu then
		return '请使用 F10 菜单指派攻击目标'
	end

	local launchAttack = function(target)
		if casTargetMenu then
			if Group.getByName('cas1') then
				local err = bc:engageZone(target, 'cas1')
				if err then
					return err
				end

				trigger.action.outTextForCoalition(2, 'F-16CM 正在对' .. target .. '战区进行对地攻击', 60)
			else
				trigger.action.outTextForCoalition(2, '支援单位已离开战区或已被击毁', 60)
			end

			casTargetMenu = nil
		end
	end

	casTargetMenu = bc:showTargetZoneMenu(2, '指派 F-16CM 对地攻击目标', launchAttack, 1)

	trigger.action.outTextForCoalition(2, 'F-16CM 已就绪，请使用 F10 菜单指派攻击目标', 60)
end,
	function(sender, params)
		if params.zone and params.zone.side == 1 then
			local gr = Group.getByName('cas1')
			if Utils.isGroupActive(gr) then
				return '对地攻击任务仍在进行中'
			end

			mist.respawnGroup('cas1', true)
			mist.scheduleFunction(function(target)
				if Group.getByName('cas1') then
					local err = bc:engageZone(target, 'cas1')
					if err then
						return err
					end

					trigger.action.outTextForCoalition(2, 'F-16CM 正在对' .. target .. '战区进行对地攻击', 60)
				end
			end, { params.zone.zone }, timer.getTime() + 2)
		else
			return '仅允许攻击敌方占领区'
		end
	end)

local upgradeMenu = nil
bc:registerShopItem('supplies', '补给友方占领区', 1000, function(sender)
	if upgradeMenu then
		return '请使用 F10 菜单指派补给区域'
	end

	local upgradeZone = function(target)
		if upgradeMenu then
			local zn = bc:getZoneByName(target)
			if zn and zn.side == 2 then
				zn:upgrade()
			else
				return '所选区域不是友方占领区'
			end

			upgradeMenu = nil
		end
	end

	upgradeMenu = bc:showTargetZoneMenu(2, '指派补给区域', upgradeZone, 2)

	trigger.action.outTextForCoalition(2, '补给已就绪，请使用 F10 菜单指派补给区域', 60)
end,
	function(sender, params)
		if params.zone and params.zone.side == 2 then
			params.zone:upgrade()
		else
			return '仅允许补给友方占领区'
		end
	end)

local JTAC = JTAC
local jtacTargetMenu = nil
drone = JTAC:new({ name = 'jtacDrone' }) -- This MUST be global, as JTAC in zomeCommander.lua will directly refer to this value
bc:registerShopItem('jtac', 'MQ-1A JTAC 侦查任务', 100, function(sender)

	if jtacTargetMenu then
		return '请使用 F10 菜单指派侦查目标'
	end

	local spawnAndOrbit = function(target)
		if jtacTargetMenu then
			local zn = bc:getZoneByName(target)
			drone:deployAtZone(zn)
			drone:showMenu()
			trigger.action.outTextForCoalition(2, 'MQ-1A 已部署于' .. target .. '战区上空', 60)
			jtacTargetMenu = nil
		end
	end

	jtacTargetMenu = bc:showTargetZoneMenu(2, '部署 MQ-1A', spawnAndOrbit, 1)

	trigger.action.outTextForCoalition(2, 'MQ-1A 已就绪，请使用 F10 菜单指派侦查区域', 60)
end,
	function(sender, params)
		if params.zone and params.zone.side == 1 then
			drone:deployAtZone(params.zone)
			drone:showMenu()
			trigger.action.outTextForCoalition(2, 'MQ-1A 已部署于' .. params.zone.zone .. '战区上空', 60)
		else
			return '仅允许侦查敌方占领区'
		end
	end)

local smoketargets = function(tz)
	local units = {}
	for i, v in pairs(tz.built) do
		local g = Group.getByName(v)
		for i2, v2 in ipairs(g:getUnits()) do
			table.insert(units, v2)
		end
	end

	local tgts = {}
	for i = 1, 3, 1 do
		if #units > 0 then
			local selected = math.random(1, #units)
			table.insert(tgts, units[selected])
			table.remove(units, selected)
		end
	end

	for i, v in ipairs(tgts) do
		local pos = v:getPosition().p
		trigger.action.smoke(pos, 1)
	end
end

local smokeTargetMenu = nil
bc:registerShopItem('smoke', '烟雾标记', 100, function(sender)
	if smokeTargetMenu then
		return '请使用 F10 菜单指派标记区域'
	end

	local launchAttack = function(target)
		if smokeTargetMenu then
			local tz = bc:getZoneByName(target)
			smoketargets(tz)
			smokeTargetMenu = nil
			trigger.action.outTextForCoalition(2, '已用红色烟雾标记' .. target .. '战区的目标', 60)
		end
	end

	smokeTargetMenu = bc:showTargetZoneMenu(2, '指派烟雾标记目标', launchAttack, 1)

	trigger.action.outTextForCoalition(2, '烟雾标记已就绪，请使用 F10 菜单指派标记区域', 60)
end,
	function(sender, params)
		if params.zone and params.zone.side == 1 then
			smoketargets(params.zone)
			trigger.action.outTextForCoalition(2, '已用红色烟雾标记' .. params.zone.zone .. '战区的目标', 60)
		else
			return '仅允许标记敌方占领区'
		end
	end)

local spawn_awacs_e2d = function(sender)
	local gr = Group.getByName('awacs-e2d-255am')
	if Utils.isGroupActive(gr) then
		return 'E-2D 空中预警机 仍在执行任务\n呼号：Darkstar\n无线电频率：255.00 MHz AM'
	end
	mist.respawnGroup('awacs-e2d-255am', true)
	trigger.action.outTextForCoalition(2, 'E-2D 空中预警机已上线\n呼号：Darkstar\n无线电频率：255.00 MHz AM', 60)
	GroupFunctions.delayedDestroyGroupByName("awacs-e2d-255am", 3600, "E-2D 空中预警机 已离开空域")
end
bc:registerShopItem('awacs-e2d-255am', 'E-2D 空中预警机(AWACS)', 100, spawn_awacs_e2d, spawn_awacs_e2d)

local spawn_awacs_a50 = function(sender)
	local gr = Group.getByName('awacs-a50-124am')
	if Utils.isGroupActive(gr) then
		return 'A-50 空中预警机 仍在执行任务\n呼号：Overlord\n无线电频率：124.00 MHz AM'
	end
	mist.respawnGroup('awacs-a50-124am', true)
	trigger.action.outTextForCoalition(2, 'A-50 空中预警机已上线\n呼号：Overlord\n无线电频率：124.00 MHz AM', 60)
	GroupFunctions.delayedDestroyGroupByName("awacs-a50-124am", 3600, "A-50 空中预警机 已离开空域")
end
bc:registerShopItem('awacs-a50-124am', 'A-50 空中预警机(AWACS)', 100, spawn_awacs_a50, spawn_awacs_a50)

local spawnAirrefuelSoft = function(sender)
	local gr = Group.getByName('airrefuel-soft')
	if Utils.isGroupActive(gr) then
		return 'KC-135MPRS 空中加油机(软管) 仍在执行任务\n呼号：Texaco\n无线电频率：251.00 MHz AM'
	end
	mist.respawnGroup('airrefuel-soft', true)
	trigger.action.outTextForCoalition(2, 'KC-135MPRS 空中加油机(软管) 已上线\n呼号：Texaco\n无线电频率：251.00 MHz AM', 60)
	GroupFunctions.delayedDestroyGroupByName("airrefuel-soft", 3600, "KC-135MPRS 空中加油机(软管) 已离开空域")
end
bc:registerShopItem('airrefuel-soft', 'KC-135MPRS 空中加油机(软管)', 100, spawnAirrefuelSoft, spawnAirrefuelSoft)

local spawnAirrefuelHard = function(sender)
	local gr = Group.getByName('airrefuel-hard')
	if Utils.isGroupActive(gr) then
		return 'KC-135 空中加油机(硬管) 仍在执行任务\n呼号：Arco\n无线电频率：252.00 MHz AM'
	end
	mist.respawnGroup('airrefuel-hard', true)
	trigger.action.outTextForCoalition(2, 'KC-135 空中加油机(硬管) 已上线\n呼号：Arco\n无线电频率：252.00 MHz AM', 60)
	GroupFunctions.delayedDestroyGroupByName("airrefuel-hard", 3600, "KC-135 空中加油机(硬管) 已离开空域")
end
bc:registerShopItem('airrefuel-hard', 'KC-135 空中加油机(硬管)', 100, spawnAirrefuelHard, spawnAirrefuelHard)

local jamMenu = nil
bc:registerShopItem('jam', '雷达干扰 (Radar Jamming)', 2500, function(sender)
	local gr = Group.getByName('ewAircraft')
	if Utils.isGroupActive(gr) then
		return '雷达干扰任务仍在进行中'
	end
	mist.respawnGroup('ewAircraft', true)
	if jamMenu then
		return '请使用 F10 菜单指派目标区域'
	end
	local startJam = function(target)
		if jamMenu then
			bc:jamRadarsAtZone('ewAircraft', target)
			jamMenu = nil
			trigger.action.outTextForCoalition(2, "E/A-18 Growler 正在干扰 " .. target .. " 区域的雷达", 60)
		end
	end
	jamMenu = bc:showTargetZoneMenu(2, '指派雷达干扰目标', startJam, 1)
	trigger.action.outTextForCoalition(2, '请使用 F10 菜单指派目标区域', 60)
end,
function(sender, params)
	if params.zone and params.zone.side == 1 then
		local gr = Group.getByName('ewAircraft')
		if Utils.isGroupActive(gr) then
			return '雷达干扰任务仍在进行中'
		end
		mist.respawnGroup('ewAircraft', true)
		mist.scheduleFunction(function(target)
			local ew = Group.getByName('ewAircraft')
			if ew then
				local err = bc:jamRadarsAtZone('ewAircraft', target)
				if err then
					return err
				end
				trigger.action.outTextForCoalition(2, "E/A-18 Growler 正在干扰 " .. target .. " 区域的雷达", 60)
			end
		end,{params.zone.zone},timer.getTime() + 2)
	else
		return '只能对敌方占领区进行雷达干扰'
	end
end)

bc:addShopItem(2, 'sead', -1)
bc:addShopItem(2, 'sweep', -1)
bc:addShopItem(2, 'cas', -1)
bc:addShopItem(2, 'supplies', -1)
bc:addShopItem(2, 'jtac', -1)
bc:addShopItem(2, 'smoke', -1)
bc:addShopItem(2, 'awacs-e2d-255am', -1)
bc:addShopItem(2, 'awacs-a50-124am', -1)
bc:addShopItem(2, 'airrefuel-soft', -1)
bc:addShopItem(2, 'airrefuel-hard', -1)
bc:addShopItem(2, 'jam', -1)

-- bc:addFunds(2, 100000)

-- Blue Support Done

-- Red Support

local redSupports = {
	shipAttackingFromBatumiToCarrier = {
		name = "r-support-ship-batumi-carrier",
		description = "Ship Attacking from Batumi to Blue Carrier",
		price = 1000,
		random = 0,
		groupNames = {
			"r-support-ship-batumi-carrier-1",
		},
		zones = {
			base = {
				name = "Batumi",
				side = 1,
			},
		},
		hint = {
			side = 2,
			text = "敌军正在派遣舰队攻击我方航母！\n起点: Batumi\n攻击目标: 蓝方航母作战集群",
		},
	},
	shipAttackingFromPortToSochi = {
		name = "r-support-ship-port-sochi",
		description = "Ship Attacking from Port to Sochi",
		price = 1000,
		random = 0, -- Any value <= 0 or >= 100 will always spawn all groups
		groupNames = {
			"r-support-ship-port-sochi-1",
		},
		zones = {
			base = {
				name = "Port",
				side = 1,
			},
			target = {
				name = "Sochi",
				side = 2,
			},
		},
		hint = {
			side = 2,
			text = "敌军正在派遣舰队攻击我方起始机场！\n起点: Port\n攻击目标: Sochi",
		},
	},
	antishipFromBatumiToCarrier = {
		name = "r-support-antiship-batumi-carrier",
		description = "Anti-Ship Attack from Batumi to Blue Carrier",
		price = 1000,
		random = 25,
		groupNames = {
			"r-support-antiship-batumi-carrier-f18c",
			"r-support-antiship-batumi-carrier-f16c",
			"r-support-antiship-batumi-carrier-su34",
		},
		zones = {
			base = {
				name = "Batumi",
				side = 1,
			},
		},
		hint = {
			side = 2,
			text = "敌军正在派遣机队攻击我方航母！\n起点: Batumi\n攻击目标: 蓝方航母作战集群",
		},
	},
	bomberFromKutaisiToSenaki = {
		name = "r-support-bomber-kutaisi-senaki",
		description = "Bomber Attack from Kutaisi to Senaki",
		price = 1000,
		random = 0,
		groupNames = {
			"r-support-bomber-kutaisi-senaki-b1b",
			"r-support-bomber-kutaisi-senaki-f16c",
		},
		zones = {
			base = {
				name = "Kutaisi",
				side = 1,
			},
			target = {
				name = "Senaki",
				side = 2,
			},
		},
		hint = {
			side = 2,
			text = "敌军正在派遣轰炸机机队攻击我方机场！\n起点: Kutaisi\n攻击目标: Senaki",
		},
	},
	rocketFromDeltaToSukhumi = {
		name = "r-support-delta-sukhumi-rocket",
		description = "Rocket Attack from Delta to Sukhumi",
		price = 100,
		random = 0,
		groupNames = {
			"r-support-delta-sukhumi-rocket"
		},
		zones = {
			base = {
				name = "Delta",
				side = 1,
			},
			target = {
				name = "Sukhumi",
				side = 2,
			},
		},
		hint = {
			side = 2,
			text = "敌军正在派遣火箭发射车攻击我方机场！\n起点: Delta\n攻击目标: Sukhumi",
		},
	},
	rocketFromSukhumiToGudauta = {
		name = "r-support-sukhumi-gudauta-rocket",
		description = "Rocket Attack from Sukhumi to Gudauta",
		price = 100,
		random = 0,
		groupNames = {
			"r-support-sukhumi-gudauta-rocket"
		},
		zones = {
			base = {
				name = "Sukhumi",
				side = 1,
			},
			target = {
				name = "Gudauta",
				side = 2,
			},
		},
		hint = {
			side = 2,
			text = "敌军正在派遣火箭发射车攻击我方机场！\n起点: Sukhumi\n攻击目标: Gudauta",
		},
	},
}

local function zoneMatch(zoneMatchList)
	local result = true
	for key, value in pairs(zoneMatchList) do
		result = result and bc:getZoneByName(value.name).side == value.side
	end
	return result
end

local function NewRedSupport(support)
	bc:registerShopItem(support.name, support.description, support.price, function(sender)
		if not zoneMatch(support.zones) then
			return "zones mismatch"
		end
		if GroupFunctions.areGroupsActiveByNames(support.groupNames) then
			return "groups still active"
		end
		local selectedGroupNames = {}
		if support.random > 0 and support.random < 100 then -- Actually spawned group amount based on random value
			for key, value in pairs(support.groupNames) do
				if math.random(1, 100) < support.random then
					table.insert(selectedGroupNames, value)
				end
			end
			if #selectedGroupNames == 0 then -- At least spawn one group
				table.insert(selectedGroupNames, support.groupNames[math.random(1, #support.groupNames)])
			end
		else
			selectedGroupNames = support.groupNames
		end
		GroupFunctions.respawnGroupsByNames(selectedGroupNames)
		trigger.action.outTextForCoalition(support.hint.side, support.hint.text, 60)
	end)
	bc:addShopItem(1, support.name, -1)
end

local function InitRedSupports()
	for key, value in pairs(redSupports) do
		NewRedSupport(value)
	end
end

InitRedSupports()

-- bc:addFunds(1, 100000)
-- BudgetCommander:new({ battleCommander = bc, side = 1, decissionFrequency = 1, decissionVariance = 1, skipChance = 0 }):init()

BudgetCommander:new({ battleCommander = bc, side = 1, decissionFrequency = 15 * 60, decissionVariance = 15 * 60, skipChance = 25 }):init()

-- Red Support Done

-- Spawn Carrier Patrols
-- This is special as the zone is not registed as a normal zone

local carrierPatrols = {
	["r-cvn61"] = "r-patrol-rcvn61-rcvn61-su33",
	["r-cvn73"] = "r-patrol-rcvn73-rcvn73-f18c",
	["r-cvn74"] = "r-patrol-rcvn74-rcvn74-f14b",
	["b-cvn73"] = "b-patrol-bcvn73-bcvn73-f18c",
}

GroupFunctions.destroyGroupsByNames(carrierPatrols)

local carrierAirGroupSpawn = function(event, sender)
	for key, value in pairs(carrierPatrols) do
		if not GroupFunctions.isGroupDeadByName(key) then -- Make sure the carrier is alive
			local group = Group.getByName(value)
			if GroupFunctions.isGroupDead(group) then
				if math.random(1, 100) > 50 then
					mist.respawnGroup(value, true)
				end
			elseif Utils.allGroupIsLanded(group, true) then
				group:destroy()
			end
		end
	end
end

mist.scheduleFunction(carrierAirGroupSpawn, {}, timer.getTime() + 300, 900) -- The detect duration should allow aircrafts' first-time take off, at least 60 seconds

-- Spawn Carrier Patrols Done

-- Logistics Functions
-- Pilot rescue, cargo transport, etc. in F10 Radio Menu

local logisticCommanderSupplyZones = {}
for key, value in pairs(zones) do
	table.insert(logisticCommanderSupplyZones, value.zoneCommanderProperties.zone)
end
local lc = LogisticCommander:new({ battleCommander = bc, supplyZones = logisticCommanderSupplyZones })
lc:init()

-- Logistics Functions Done

-- BattleCommander Initialization

bc:loadFromDisk() --will load and overwrite default zone levels, sides, funds and available shop items
bc:init()
bc:startRewardPlayerContribution(15, { infantry = 5, ground = 15, sam = 25, airplane = 50, ship = 100, helicopter = 50, crate = 150, rescue = 300 })

-- BattleCommander Initialization Done

-- Support C130 cargo drop

HercCargoDropSupply.init(bc)

-- Support C130 cargo drop Done

-- Spawn FARP Trucks

local farpTrucks = {
	["Sochi"] = "farp-trucks-sochi",
	["Gudauta"] = "farp-trucks-gudauta",
	["Sukhumi"] = "farp-trucks-sukhumi",
	["Senaki"] = "farp-trucks-senaki",
	["Kobuleti"] = "farp-trucks-kobuleti",
	["Kutaisi"] = "farp-trucks-kutaisi",
	["Batumi"] = "farp-trucks-batumi",
	["Alpha"] = "farp-trucks-alpha",
	["Bravo"] = "farp-trucks-bravo",
	["Radio"] = "farp-trucks-radio",
	["Charlie"] = "farp-trucks-charlie",
	["Delta"] = "farp-trucks-delta",
	["Port"] = "farp-trucks-port",
	["SAM"] = "farp-trucks-sam",
	["Oil"] = "farp-trucks-oil",
	["Echo"] = "farp-trucks-echo",
}

GroupFunctions.destroyGroupsByNames(farpTrucks)

local function spawnFarpTrucks()
	for key, value in pairs(farpTrucks) do
		local farp = bc:getZoneByName(key)
		if farp ~= nil then
			local group = Group.getByName(value)
			if farp.side==2 then
				if GroupFunctions.isGroupDead(group) then
					mist.respawnGroup(value)
				end
			else
				if group and not GroupFunctions.isGroupDead(group) then
					group:destroy()
				end
			end
		end
	end
end

mist.scheduleFunction(spawnFarpTrucks, {}, timer.getTime() + 5, 90)

-- Spawn FARP Trucks Done

-- Delete Ejected Pilots

local event_handler = {}

function event_handler:onEvent(event)
	if event.id == world.event.S_EVENT_LANDING_AFTER_EJECTION and event.initiator and event.initiator:isExist() then
		event.initiator:destroy()
	end
end

world.addEventHandler(event_handler)

-- Delete Ejected Pilots Done

-- Construct ctld.pickupZones from Zone Defination

function getPickupZonesList()
	local pickup_zones_list = {}

	for key, value in pairs(zones) do
		table.insert(pickup_zones_list, {value.zoneCommanderProperties.zone, "blue", -1, "yes", 2})
	end
	
	return pickup_zones_list
end

-- Construct ctld.pickupZones from Zone Defination Done
