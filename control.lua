local Game = require('stdlib.game')
local Area = require('stdlib.area.area')
local Resource = require('stdlib.entity.resource')
local Chunk = require('stdlib.area.chunk')
local Entity = require('stdlib/entity/entity')
require("stdlib.event.event")

local ResourceConfig = require('config')

local MOD = {}
MOD.name = "Resource Labels"

Event.register(Event.core_events.init,
    function()
        global.chunksToLabel = {}
        global.labeledResourcePatches = {}
        global.isLabeling = {}
    end
)

Event.register("resource-labels-add",
    function(event)
        local player = Game.get_player(event.player_index)
        local force = player.force

        local cooldown = settings.global["resource-labels-cooldown"].value

        if not global.isLabeling[force.name] then
            global.isLabeling[force.name] = {}
            global.isLabeling[force.name]["stop"] = -cooldown
            global.isLabeling[force.name]["initiator"] = ""
        end

        local stop = global.isLabeling[force.name].stop
        if stop + cooldown <= event.tick then
            local surface = player.surface
            local force = player.force

            local scheduledTick = game.tick
            local scheduleInterval = settings.global["resource-labels-schedule-interval"].value

            for chunk in surface.get_chunks() do
                if force.is_chunk_charted(surface, chunk) and surface.count_entities_filtered{area=Chunk.to_area(chunk), type="resource"} > 0 then
                    scheduledTick = scheduledTick + scheduleInterval
                    scheduleLabelingForChunk(scheduledTick, player, surface, chunk)
                end
            end
            global.isLabeling[force.name].stop = scheduledTick
            global.isLabeling[force.name].initiator = player.name
        elseif stop <= event.tick then
            player.print{"resource-labels-cooldown-msg", stop + cooldown - event.tick}
        else
            local initiator = global.isLabeling[force.name].initiator
            player.print{"resource-labels-already-running-msg", initiator, stop - event.tick}
        end
    end
)

function scheduleLabelingForChunk(scheduledTick, player, surface, chunk)
    if not global.chunksToLabel[scheduledTick] then
        global.chunksToLabel[scheduledTick] = {}
    end

    table.insert(global.chunksToLabel[scheduledTick], {player, surface, Chunk.to_area(chunk)})
end

Event.register(defines.events.on_tick,
    function(event)
        if global.chunksToLabel[event.tick] ~= nil then
            table.each(global.chunksToLabel[event.tick], function(data)
                labelResourcesInArea(unpack(data))
            end)

            global.chunksToLabel[event.tick] = nil
        end
    end
)

function labelResourcesInArea(player, surface, area)
    local surface = player.surface
    local resources = surface.find_entities_filtered{area=area, type="resource"}

    if #resources > 0 then
        local resourceTypes = Resource.get_resource_types(resources)
        for _,type in pairs(resourceTypes) do
            local resourcesFiltered = Resource.filter_resources(resources, {type})

            local entity = table.first(resourcesFiltered)
            local patch = Resource.get_resource_patch_at(surface, entity.position, type)

            createLabelForResourcePatch(player, surface, patch)
        end
    end
end

function createLabelForResourcePatch(player, surface, patch)
    local force = player.force

    if not isAlreadyLabeled(force, surface, patch) then
        local bounds = Resource.get_resource_patch_bounds(patch)
        local centerPosition = Area.center(bounds)
        local entity = table.first(patch)

        local signalID = getSignalID(entity)

        local label = ""
        if settings.global["resource-labels-show-labels"].value then
            label = getLabel(entity)
        end

        local chartTag = {position=centerPosition, icon=signalID, text=label}

        local addedChartTag = nil
        local success = false
        
        success, addedChartTag = pcall(function()
            return force.add_chart_tag(surface, chartTag)
        end)

        if not success then
            player.print{"resource-labels-unknown-resource-entity-msg", entity.name, MOD.name}
        end

        if addedChartTag and type(addedChartTag) ~= "string" then
            addedChartTag.last_user = player

            local labeledResourceData = {
                --entities = patch,
                type = entity.name,
                surface = surface,
                bounds = {bounds.left_top, bounds.right_bottom},
                label = addedChartTag
            }

            addLabeledResourceData(force, labeledResourceData)
        end
    end
end

function isAlreadyLabeled(force, surface, patch)
    local labelData = global.labeledResourcePatches[force.name]
    if not labelData then
        return false
    end

    local bounds = Resource.get_resource_patch_bounds(patch)
    local centerPosition = Area.center(bounds)
    local type = table.first(patch).name

    return table.find(labelData, function(labeledResourceData)
        return labeledResourceData.surface.name == surface.name and labeledResourceData.type == type and Area.inside(labeledResourceData.bounds, centerPosition)
    end)
end

function getSignalID(entity)
    local signalID = nil

    local configEntry = ResourceConfig[entity.name]
    if configEntry then
        signalID = {type=configEntry.type, name=configEntry.icon}
    end

    return signalID
end

function getLabel(entity)
    local label = ""

    local configEntry = ResourceConfig[entity.name]
    if configEntry then
        label = configEntry.label
    end

    return label
end

function addLabeledResourceData(force, labeledResourceData)
    if not global.labeledResourcePatches[force.name] then
        global.labeledResourcePatches[force.name] = {}
    end 

    table.insert(global.labeledResourcePatches[force.name], labeledResourceData)
end

Event.register("resource-labels-remove",
    function(event)
        local player = Game.get_player(event.player_index)
        local force = player.force
        local currentTick = event.tick

        removeLabels(currentTick, player)
    end
)

function removeLabels(currentTick, player)
    local force = player.force
    local isLabeling = global.isLabeling[force.name]

    if currentTick <= isLabeling.stop then
        local initiator = isLabeling.initiator
        player.print{"resource-labels-remove-but-not-finished-msg", initiator, isLabeling.stop - currentTick}
    else
        local labelData = global.labeledResourcePatches[force.name]
        if labelData then
            table.each(labelData, function(labeledResourceData)
                local label = labeledResourceData.label
                if label.valid then
                    label.destroy()
                end
            end)
        end

        global.labeledResourcePatches[force.name] = nil
    end
end
