local pairs = pairs
local table = table
local Group = Group
local mist = mist

GroupFunctions = {}

function GroupFunctions.getGroupsByNames(names)
    local groups = {}
    for key, value in pairs(names) do
        local group = Group.getByName(value)
        if group ~= nil then
            table.insert(groups, group)
        end
    end
    return groups
end

function GroupFunctions.destroyGroup(group)
    if group ~= nil then
        group:destroy()
    end
end

function GroupFunctions.destroyGroups(groups)
    for key, value in pairs(groups) do
        GroupFunctions.destroyGroup(value)
    end
end

function GroupFunctions.delayedDestroyGroupByName(name, delay, message)
    mist.scheduleFunction(function(name, message)
        local group = Group.getByName(name)
        if group ~= nil then
            if message ~= nil then
                trigger.action.outTextForCoalition(group:getCoalition(), message, 60)
            end
            GroupFunctions.destroyGroup(group)
        end
    end, { name, message }, timer.getTime() + delay)
end

function GroupFunctions.destroyGroupsByNames(names)
    GroupFunctions.destroyGroups(GroupFunctions.getGroupsByNames(names))
end

function GroupFunctions.respawnGroupsByNames(names, task)
    for key, value in pairs(names) do
        mist.respawnGroup(value, task)
    end
end

function GroupFunctions.areGroupsActive(groups)
    local active = false
    for key, value in pairs(groups) do
        active = active or value ~= nil and value:getSize() > 0 and value:getController():hasTask()
    end
    return active
end

function GroupFunctions.areGroupsActiveByNames(names)
    -- Each time a group is respawned, it is a NEW group, so it MUST be done during runtime
    return GroupFunctions.areGroupsActive(GroupFunctions.getGroupsByNames(names))
end

function GroupFunctions.isGroupDead(group)
    if group ~= nil then
        local units = group:getUnits()
        for key, unit in pairs(units) do
            if unit and unit:getLife() >= 1 then
                return false
            end
        end
    end

    return true
end

function GroupFunctions.isGroupDeadByName(name)
    return GroupFunctions.isGroupDead(Group.getByName(name))
end

function GroupFunctions.spawnGroupInZone(groupName, zoneName)
    local vars = {
        validTerrain = { 'LAND', 'ROAD', 'RUNWAY' },
        groupName = groupName,
        point = mist.getRandomPointInZone(zoneName),
        action = 'respawn',
        disperse = true,
        initTasks = true
    }

    mist.teleportToPoint(vars)
end

function GroupFunctions.cloneGroupAtPoint(groupName, point)
    local vars = {
        validTerrain = { 'LAND', 'ROAD', 'RUNWAY' },
        groupName = groupName,
        point = point,
        action = 'clone',
        disperse = true,
        initTasks = true
    }

    mist.teleportToPoint(vars)
end
