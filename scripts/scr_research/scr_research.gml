function researchProject() constructor {

	key = "none";
	name = "none";
	icon = spr_icon_energyPack;
	
	category = "meta";
	
	description = "";

	level = 0;
	maxLevel = 5;

	progress = {};

	passives = {};
	resourceCosts = undefined;
	
	requiredResearch = ["fixResearchStation"];

	static setupFunc = undefined;
	static formatDescription = undefined;
	
}

function scr_research_loadProject(savedProject) {

	if (!is_struct(savedProject)) {
		
		return undefined;
		
	}
	
	if (!variable_struct_exists(savedProject, "key")) {
		
		return undefined;
		
	}

	var const = variable_struct_get(
		global.data.researchConstructors,
		savedProject.key
	);

	if (is_undefined(const)) return undefined;

	if (is_instanceof(savedProject, const)) return savedProject;

	var loadedProject = new const();

	loadedProject.level = savedProject.level;
	
	if (variable_struct_exists(savedProject, "progress") and is_struct(savedProject.progress)) {
		loadedProject.progress = savedProject.progress;
	}

	loadedProject.setupFunc();

	return loadedProject;

}

function scr_research_hasRequirements(project) {
	
	if (!is_instanceof(project, researchProject)) return false;
	if (!is_struct(project.progress)) project.progress = {}
	if (!is_struct(project.resourceCosts)) project.setupFunc();
	if (!is_struct(project.resourceCosts)) return false;
	
	var keys = variable_struct_get_names(project.resourceCosts);
	var len = array_length(keys);
	
	for (var i = 0; i < len; i++) {
		
		var key = keys[i];
		var required = project.resourceCosts[$ key];
		
		var current = 0;
		
		if (variable_struct_exists(project.progress, key)) {
			current = project.progress[$ key];
		}
		
		if (current < required) return false;
		
	}
	
	return true;
	
}

function scr_research_levelUp(project) {
	
	if (!is_instanceof(project, researchProject)) return false;
	if (project.level >= project.maxLevel) return false;
	
	if (!scr_research_hasRequirements(project)) return false;
	
	project.level ++;
	project.setupFunc();
	project.progress = {};
	
	if (project.level >= project.maxLevel) global.gameData.research.currentResearch = undefined;
	
	return true;
	
}

function scr_research_formatDescription(project) {
	
	if (!is_instanceof(project, researchProject)) return "";
	
	var currentLevel = project.level;
	
	//current passives
	project.setupFunc();
	var currentPassives = variable_clone(project.passives);
	
	//next level passives
	project.level = min(currentLevel + 1, project.maxLevel);
	project.setupFunc();
	var nextPassives = variable_clone(project.passives);
	
	//restore project
	project.level = currentLevel;
	project.setupFunc();
	
	var txt = project.name + "   lvl " + string(currentLevel) + " / " + string(project.maxLevel) + "\n\n";
	
	var keys = variable_struct_get_names(nextPassives);
	keys = scr_stats_orderStatKeys(keys);
	
	var keysLen = array_length(keys);
	
	for (var i = 0; i < keysLen; i++) {
		
		var key = keys[i];
		
		var currentVal = variable_struct_exists(currentPassives, key)
			? currentPassives[$ key]
			: 0;
		
		var nextVal = nextPassives[$ key];
		
		var statTxt = scr_stats_getName(key);
		
		txt += "- " + statTxt + ": ";
		
		if (currentLevel <= 0) {
			
			txt += string(nextVal);
			
		} else {
			
			txt += string(currentVal) + " > " + string(nextVal);
			
		}
		
		if (i < keysLen - 1) txt += "\n";
		
	}
	
	if (is_callable(project.formatDescription)) {
		
		project.description = "";
		
		project.formatDescription();
	
	}
	
	if (!is_undefined(project.description) and project.description != "") {
	
		txt += "\n\n" + project.description;
	
	}
	
	return txt;
	
}

function scr_research_formatProgress(project) {
	
	if (!is_instanceof(project, researchProject)) return [];
	
	var resourceCosts = project.resourceCosts;
	var progress = project.progress;
	
	if (!is_struct(resourceCosts)) return [];
	if (!is_struct(progress)) return [];
	
	var resourceData = global.data.resources;
	
	var formatted = [];
	
	var keys = variable_struct_get_names(resourceCosts);
	var len = array_length(keys);
	
	for (var i = 0; i < len; i++) {
		
		var key = keys[i];
		var required = resourceCosts[$ key];
		
		var current = 0;
		
		if (variable_struct_exists(progress, key)) {
			current = progress[$ key];
		}
		
		var icon = undefined;
		var name = "none";
		
		if (variable_struct_exists(resourceData, key)) {
			
			var info = resourceData[$ key];
			icon = info.icon;
			name = info.name;
			
		}
		
		var currentString = scr_formatNumberCompact(current);
		var requiredString = scr_formatNumberCompact(required);
		
		array_push(formatted, {
			txt: name + ":   " + currentString + " / " + requiredString,
			icon: icon
		});
		
	}
	
	return formatted;
	
}

function scr_research_drawProgress(costs, xx, yy, font = fnt_normal, gap = 16) {
	
	if (!is_array(costs)) exit;
	
	draw_set_font(font);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
	var len = array_length(costs);
	
	var textH = font_get_size(font);
	var rowH = textH + gap;
	
	for (var i = 0; i < len; i++) {
		
		var cost = costs[i];
		
		var drawX = xx;
		var drawY = yy + i * rowH;
		
		if (!is_undefined(cost.icon)) {
			
			var iconW = sprite_get_width(cost.icon);
			var iconH = sprite_get_height(cost.icon);
			
			draw_sprite(cost.icon, 0, drawX, drawY);
			
			drawX += iconW + gap;
			
		}
		
		draw_text(drawX, drawY, cost.txt);
		
	}
	
}

function scr_research_getProject(key) {
	
	var research = global.gameData.research;
	
	if (!is_struct(research)) return undefined;
	if (!is_struct(research.categories)) return undefined;
	
	var categories = research.categories;
	var categoryKeys = variable_struct_get_names(categories);
	var len = array_length(categoryKeys);
	
	for (var i = 0; i < len; i++) {
		
		var categoryKey = categoryKeys[i];
		var category = categories[$ categoryKey];
		
		if (!is_struct(category.projects)) continue;
		
		if (variable_struct_exists(category.projects, key)) {
			return category.projects[$ key];
		}
		
	}
	
	return undefined;
	
}

function scr_research_addResource(key, amount) {
	
	var research = global.gameData.research;
	var currentKey = research.currentResearch;
	
	if (is_undefined(currentKey)) {
		
		scr_data_addResourceGamedata(key, amount);
		return;
		
	}
	
	var project = scr_research_getProject(currentKey);
	
	if (!is_instanceof(project, researchProject)) {
		
		scr_data_addResourceGamedata(key, amount);
		return;
		
	}
	
	if (!variable_struct_exists(project.resourceCosts, key)) {
		
		scr_data_addResourceGamedata(key, amount);
		return;
		
	}
	
	if (!variable_struct_exists(project.progress, key)) {
		project.progress[$ key] = 0;
	}
	
	var required = project.resourceCosts[$ key];
	var current = project.progress[$ key];
	
	var remaining = max(0, required - current);
	var contributed = min(amount, remaining);
	
	project.progress[$ key] += contributed;
	
	var leftover = amount - contributed;
	
	if (leftover > 0) {
		scr_data_addResourceGamedata(key, leftover);
	}
	
}

function scr_research_activateProject(project) {
	
	if (!is_instanceof(project, researchProject)) return false;
	if (project.level <= 0) return false;
	
	var research = global.gameData.research;
	var categories = research.categories;
	
	if (!variable_struct_exists(categories, project.category)) return false;
	
	var category = categories[$ project.category];
	
	category.selected = project.key;
	
	return true;
	
}

function scr_research_getActiveProjectKey(categoryKey) {
	
	var research = global.gameData.research;
	var categories = research.categories;
	
	if (!variable_struct_exists(categories, categoryKey)) return undefined;
	
	var category = categories[$ categoryKey];
	
	return category.selected;
	
}

//PROJECTS

//bionics
function project_vitality() : researchProject() constructor {

	name = "Vitality";
	key = "vitality";
	category = "bionics";
	icon = spr_icon_enhancedHomeostasis;

	maxLevel = 24;
	
	static setupFunc = function() {
		
		passives.maxHp = level * 10;
		if (level >= 3) passives.hpRegen = (level div 3) * 0.5;
		
		var pow = power(level, 3);
		
		resourceCosts = {
			data: 300 + pow * 100,
			bio: 30 + pow * 20
		};
		
		if ((level + 1) mod 3) == 0 {
			
			resourceCosts.mutantOrgan = 15 + pow * 5;
			
		}
		
	}
	
	static formatDescription = function() {
	
		description = "Each level increases maximum health by 10";
		description += "\nEvery 3 levels increases health regeneration by 0.4";
		
	}
	
}

function project_survival() : researchProject() constructor {

	name = "Survival";
	key = "survival";
	category = "bionics";
	icon = spr_icon_enhancedHomeostasis;

	maxLevel = 24;
	
	static setupFunc = function() {
		
		passives.hpRegen = level * 0.3;
		if (level >= 3) passives.healingPerc = (level div 3) * 5;
		
		var pow = power(level, 3);
		
		resourceCosts = {
			data: 300 + pow * 100,
			bio: 30 + pow * 20
		};
		
		if ((level + 1) mod 3) == 0 {
			
			resourceCosts.alienOrgan = 15 + pow * 5;
			
		}
		
	}
	
	static formatDescription = function() {
	
		description = "Each level increases health regeneration by 0.3";
		description += "\nEvery 3 levels increases healing % by 5";
		
	}
	
}

function project_agility() : researchProject() constructor {

	name = "Agility";
	key = "agility";
	category = "bionics";
	icon = spr_icon_enhancedHomeostasis;

	maxLevel = 24;
	
	static setupFunc = function() {
		
		passives.da = level * 5;
		if (level >= 4) passives.dashRegen = (level div 4) * 0.02;
		
		var pow = power(level, 3);
		
		resourceCosts = {
			data: 300 + pow * 100,
			bio: 30 + pow * 20
		};
		
		if ((level + 1) mod 3) == 0 {
			
			resourceCosts.fissiles = 10 + pow * 4;
			
		}
		
	}
	
	static formatDescription = function() {
	
		description = "Each level increases DA by 5";
		description += "\nEvery 4 levels increases dash regen by .02";
		if (level < 12) description += "\nLevel 12: 1 + dash charge";
		
	}
	
}

function project_strength() : researchProject() constructor {

	name = "Strength";
	key = "strength";
	category = "bionics";
	icon = spr_icon_enhancedHomeostasis;

	maxLevel = 24;
	
	static setupFunc = function() {
		
		passives.meleeDamPerc = level * 3;
		if (level >= 3) passives.da = (level div 3) * 10;
		
		var pow = power(level, 3);
		
		resourceCosts = {
			data: 300 + pow * 100,
			bio: 30 + pow * 10,
			metals: 20 + pow * 10
		};
		
		if ((level + 1) mod 3) == 0 {
			
			resourceCosts.mutantOrgan = 15 + pow * 5;
			
		}
		
	}
	
	static formatDescription = function() {
	
		description = "Each level increases melee damage % by 3";
		description += "\nEvery 3 levels increases DA by 10";
		
	}
	
}

//function project_fixResearchStation() : researchProject("fixResearchStation") constructor {

//	name = "Repair Research Station";
//	category = "meta";
	
//	requiredResearch = [];
	
//	static setupFunc = function() {
		
//		passives = {};
		
//		resourceCosts = {
//			metals: 100,
//			polymers: 50,
//			fissiles: 1
//		};
		
//	}
		
//}

//function project_vitality() : researchProject("vitality") constructor {

//	name = "Vitality";
//	category = "survival";
	
//	static setupFunc = function() {
		
//		passives.maxHp = level * 25;
		
//		resourceCosts = {
//			data: 500 + level * level * 200
//		};
		
//	}
		
//}

//function project_shielding() : researchProject("shielding") constructor {

//	name = "Shielding";
//	category = "survival";
	
//	static setupFunc = function() {
		
//		passives.maxShield = level;
		
//		resourceCosts = {
//			data: 800 + level * level * 400
//		};
		
//	}
		
//}


////COMBAT

//function project_targeting() : researchProject("targeting") constructor {

//	name = "Targeting";
//	category = "combat";
	
//	static setupFunc = function() {
		
//		passives.oa = level * 8;
		
//		resourceCosts = {
//			data: 500 + level * level * 200
//		};
		
//	}
	
//}

//function project_ballistics() : researchProject("ballistics") constructor {

//	name = "Ballistics";
//	category = "combat";
	
//	static setupFunc = function() {
		
//		passives.gunDamPerc = level * 5;
		
//		resourceCosts = {
//			data: 500 + level * level * 200
//		};
		
//	}
	
//}


////UTILITY

//function project_conditioning() : researchProject("conditioning") constructor {

//	name = "Conditioning";
//	category = "utility";
	
//	static setupFunc = function() {
		
//		passives.spd = level * 0.05;
		
//		resourceCosts = {
//			data: 500 + level * level * 200
//		};
		
//	}
	
//}

//function project_energyRecovery() : researchProject("energyRecovery") constructor {

//	name = "Energy Recovery";
//	category = "utility";
	
//	static setupFunc = function() {
		
//		passives.energyRegen = level * 0.05;
		
//		resourceCosts = {
//			data: 500 + level * level * 200
//		};
		
//	}
	
//}