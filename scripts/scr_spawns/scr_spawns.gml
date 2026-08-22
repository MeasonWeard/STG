function enemySpawn(obj, minLevel = 1, maxLevel = 1, minWeight = 100, maxWeight = 100) constructor {

	object = obj;

	minLvl = minLevel;
	maxLvl = maxLevel;

	minW = minWeight;
	maxW = maxWeight;

	static calculateWeight = function(level) {

		if (level < minLvl) return 0;

		if (maxLvl <= minLvl) {
			return maxW;
		}

		var dec = clamp(
			(level - minLvl) / (maxLvl - minLvl),
			0,
			1
		);

		return lerp(minW, maxW, dec);

	}

}

function enemyGroup(groupName = "none", groupSpawns = []) constructor {

	name = groupName;
	spawns = groupSpawns;

	static calculate = function(level) {

		var result = [];

		for (var i = 0; i < array_length(spawns); i++) {

			var enemy = spawns[i];

			var weight = enemy.calculateWeight(level);

			if (weight <= 0) continue;

			array_push(
				result,
				[enemy.object, weight]
			);

		}

		return result;

	}

}

function scr_spawns_testGroups() {

	var minorGroups = [];
	var majorGroups = [];

	var groupMutantsMinor = new enemyGroup();
	groupMutantsMinor.spawns = [
		new enemySpawn(obj_bertha),
		new enemySpawn(obj_celia, 10, 20, 10, 35),
		new enemySpawn(obj_fourGuns, 12, 25, 2, 12)
	];
	
	var groupSpidersMinor = new enemyGroup();
	groupSpidersMinor.name = "spooder";
	groupSpidersMinor.spawns = [
		new enemySpawn(obj_spiderDrone),
		new enemySpawn(obj_spiderDroneKamikaze, 3, 10, 20, 20),
		new enemySpawn(obj_bigSpider, 8, 20, 8, 25)
	];
	
	var groupPlantsMinor = new enemyGroup();
	groupPlantsMinor.spawns = [
		new enemySpawn(obj_plantGuy),
		new enemySpawn(obj_treeGuy, 8, 20, 8, 25)
	]

	array_push(minorGroups, groupSpidersMinor);
	array_push(minorGroups, groupMutantsMinor);
	array_push(minorGroups, groupPlantsMinor);
	
	var groupMutantsMajor = new enemyGroup();
	groupMutantsMajor.spawns = [
		new enemySpawn(obj_bertha),
		new enemySpawn(obj_celia, 1, 10, 15, 40),
		new enemySpawn(obj_fourGuns, 6, 18, 4, 20)
	];
	
	var groupSpidersMajor = new enemyGroup();
	groupSpidersMajor.spawns = [
		new enemySpawn(obj_spiderDrone),
		new enemySpawn(obj_spiderDroneKamikaze, 3, 3, 20, 20),
		new enemySpawn(obj_bigSpider, 2, 18, 15, 45)
	];
	
	var groupPlantsMajor = new enemyGroup();
	groupPlantsMajor.spawns = [
		new enemySpawn(obj_plantGuy),
		new enemySpawn(obj_treeGuy, 1, 10, 15, 40),
	]

	array_push(majorGroups, groupMutantsMajor);
	array_push(majorGroups, groupSpidersMajor);
	array_push(majorGroups, groupPlantsMajor);
	
	return {
		minor: minorGroups,
		major: majorGroups
	}
	
}