data:extend({
	{
		type = "int-setting",
		name = "resource-labels-schedule-interval",
		setting_type = "runtime-global",
		default_value = 20,
		minimum_value = 0,
		order = "ba"
	},
	{
		type = "bool-setting",
		name = "resource-labels-show-labels",
		setting_type = "runtime-global",
		default_value = false,
		order = "aa"
	},
	{
		type = "int-setting",
		name = "resource-labels-cooldown",
		setting_type = "runtime-global",
		default_value = 60,
		minimum_value = 0,
		order = "bb"
	},
	{
		type = "bool-setting",
		name = "resource-labels-show-resource-count",
		setting_type = "runtime-global",
		default_value = false,
		order = "ab"
	},
})
