local ResourceConfig = {}

-- Adds a label for a resource that has an item as mining result
-- params: entity-name, label, item-name
local function addItem(resourceEntity, label, icon)
    ResourceConfig[resourceEntity] = {label=label, type="item", icon=icon, enabled=true}
end

-- Adds a label for a resource that has a fluid as mining result
-- params: entity-name, label, fluid-name
local function addFluid(resourceEntity, label, icon)
    ResourceConfig[resourceEntity] = {label=label, type="fluid", icon=icon, enabled=true}
end

-- Adds an infinite version of an ore, note that the regular ore must be added first using addItem!
-- params: entity-name
local function addInfiniteItem(baseResourceEntity)
    local base = ResourceConfig[baseResourceEntity]
    local infiniteEntity = "infinite-" .. baseResourceEntity
    local infiniteLabel = "Infinite " .. base.label
    local infiniteIcon = base.icon

    ResourceConfig[infiniteEntity] = {label=infiniteLabel, type="item", icon=infiniteIcon, enabled=true}
end

-- Hides a previously defined resource
-- params: entity-name
local function hide(baseResourceEntity)
    ResourceConfig[baseResourceEntity].enabled = false
end

-- examples:
-- 1)
-- addItem("coal", "Coal", "coal")
-- Adds the label "Coal" with the icon of the item "coal" to entities named "coal".
-- 2)
-- hide("coal")
-- Coal will no longer be shown on the map.


--Vanilla
addItem ("coal", "Coal", "coal")
addItem ("iron-ore", "Iron", "iron-ore")
addItem ("copper-ore", "Copper", "copper-ore")
addItem ("stone", "Stone", "stone")
addItem ("uranium-ore", "Uranium", "uranium-ore")
addFluid("crude-oil", "Oil", "crude-oil")

--Bob's Ores
addItem ("gold-ore", "Gold", "gold-ore")
addItem ("lead-ore", "Lead", "lead-ore")
addItem ("silver-ore", "Silver", "silver-ore")
addItem ("tin-ore", "Tin", "tin-ore")
addItem ("tungsten-ore", "Tungsten", "tungsten-ore")
addItem ("zinc-ore", "Zinc", "zinc-ore")
addItem ("bauxite-ore", "Aluminium", "bauxite-ore")
addItem ("rutile-ore", "Titanium", "rutile-ore")
addItem ("nickel-ore", "Nickel", "nickel-ore")
addItem ("cobalt-ore", "Cobaltite", "cobalt-ore")
addItem ("quartz", "Quartz", "quartz")
addItem ("sulfur", "Sulfur", "sulfur")
addItem ("gem-ore", "Gemstones", "gem-ore")
addItem ("thorium-ore", "Thorium", "thorium-ore")
addFluid("ground-water", "Water", "water")
addFluid("lithia-water", "Lithia Water", "lithia-water")

-- Angel's Ores
addFluid("angels-fissure", "Fissure", "thermal-water")
addItem ("angels-ore1", "Saphirite", "angels-ore1")
addItem ("angels-ore2", "Jivolite", "angels-ore2")
addItem ("angels-ore3", "Stiratite", "angels-ore3")
addItem ("angels-ore4", "Crotinnium", "angels-ore4")
addItem ("angels-ore5", "Rubyte", "angels-ore5")
addItem ("angels-ore6", "Bobmonium", "angels-ore6")

-- Angel's Petrochem
addFluid("angels-natural-gas", "Natural Gas", "gas-natural-1")

-- Dark Matter Replicators
addItem ("tenemut", "Tenemut", "tenemut")

-- Deep Core Mining
addItem ("copper-ore-patch", "Copper (Deep)", "vtk-deepcore-mining-copper-ore-chunk")
addItem ("iron-ore-patch", "Iron (Deep)", "vtk-deepcore-mining-iron-ore-chunk")
addItem ("coal-patch", "Coal (Deep)", "vtk-deepcore-mining-coal-chunk")
addItem ("stone-patch", "Stone (Deep)", "vtk-deepcore-mining-stone-chunk")
addItem ("uranium-ore-patch", "Uranium (Deep)", "vtk-deepcore-mining-uranium-ore-chunk")
addItem ("vtk-deepcore-mining-crack", "Deep Core Crack", "vtk-deepcore-mining-ore-chunk")
addItem ("angels-ore1-patch", "Saphirite (Deep)", "vtk-deepcore-mining-angels-ore1-chunk")
addItem ("angels-ore2-patch", "Jivolite (Deep)", "vtk-deepcore-mining-angels-ore2-chunk")
addItem ("angels-ore3-patch", "Stiratite (Deep)", "vtk-deepcore-mining-angels-ore3-chunk")
addItem ("angels-ore4-patch", "Crotinnium (Deep)", "vtk-deepcore-mining-angels-ore4-chunk")
addItem ("angels-ore5-patch", "Rubyte (Deep)", "vtk-deepcore-mining-angels-ore5-chunk")
addItem ("angels-ore6-patch", "Bobmonium (Deep)", "vtk-deepcore-mining-angels-ore6-chunk")

-- DrugLab
addItem ("manganese-ore-dl", "Manganese", "manganese-ore-dl")
addItem ("tarsands-dl", "Tar Sand", "tarsands-dl")
addFluid("fracking-sludge-dl", "Fracking Sludge", "fracking-sludge-dl")

-- Geothermal
addFluid("geothermal", "Geothermal Water", "geothermal-water")

-- Ice Ore
addItem ("ice-ore", "Ice", "ice-ore")

-- Portal Research
addItem ("factorium-ore", "Factorium", "factorium-ore")

-- Pyanodon's Fusion
addItem ("molybdenum-ore", "Molybdenum", "molybdenum-ore")
addItem ("volcanic-pipe", "Kimberlite", "kimberlite-rock")
addItem ("regolites", "Regolite", "regolite-rock")

-- Omnimatter
addItem ("omnite", "Omnite", "omnite")
addItem ("infinite-omnite", "Infinite Omnite", "omnite")

-- Xander
addItem ("apatite", "Apatite", "apatite")
addItem ("bauxite", "Bauxite", "bauxite")
addItem ("garnierite", "Garnierite", "garnierite")
addItem ("granitic", "Granite", "granitic-ore")
addItem ("heavy-sand", "Heavy Sand", "heavy-sand")
--addItem ("lead-ore", "Lead", "lead-ore") <- covered by Bobs
addFluid("mineral-water", "Mineral Water", "mineral-water")
addFluid("natural-gas", "Natural Gas", "natural-gas")
addItem ("sulfidic-ore", "Sulfidic", "sulfidic-ore")
--addItem ("copper-ore", "Copper", "copper-ore") <- covered by Vanilla
--addFluid("crude-oil", "Oil", "crude-oil") <- covered by Vanilla
--addItem ("iron-ore", "Iron", "iron-ore") <- covered by Vanilla
--addItem ("uranium-ore", "Pitchblende", "uranium-ore") <- covered by Vanilla under different name

-- Yuoki Industries
addItem ("y-res1", "N4-Material", "y-res1")
addItem ("y-res2", "F7-Material", "y-res2")

-- Alien Wall
addItem ("alien-biomass", "Alien Biomass", "alien-biomass")

-- Angel's Infinite Ores
addInfiniteItem("coal")
addInfiniteItem("iron-ore")
addInfiniteItem("copper-ore")
addInfiniteItem("stone")
addInfiniteItem("uranium-ore")
addInfiniteItem("bauxite-ore")
addInfiniteItem("cobalt-ore")
addInfiniteItem("zinc-ore")
addInfiniteItem("tin-ore")
addInfiniteItem("quartz")
addInfiniteItem("gem-ore")
addInfiniteItem("gold-ore")
addInfiniteItem("lead-ore")
addInfiniteItem("nickel-ore")
addInfiniteItem("rutile-ore")
addInfiniteItem("silver-ore")
addInfiniteItem("sulfur")
addInfiniteItem("tungsten-ore")
addInfiniteItem("y-res1")
addInfiniteItem("y-res2")
addInfiniteItem("tenemut")
addInfiniteItem("angels-ore1")
addInfiniteItem("angels-ore2")
addInfiniteItem("angels-ore3")
addInfiniteItem("angels-ore4")
addInfiniteItem("angels-ore5")
addInfiniteItem("angels-ore6")


-- Hide resources here
-- hide("coal")

return ResourceConfig