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
	
	keys = scr_data_orderResourceKeys(keys);
	
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

function scr_research_drawProgress(costs, xx, yy, font = fnt_normal, gapY = 22, gapX = 8) {
	
	if (!is_array(costs)) exit;
	
	draw_set_font(font);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
	var len = array_length(costs);
	
	var textH = font_get_size(font);
	var rowH = textH + gapY;
	
	var iconW = sprite_get_width(spr_res_data);
	var iconH = sprite_get_height(spr_res_data);
	
	for (var i = 0; i < len; i++) {
		
		var cost = costs[i];
		
		var drawX = xx;
		var drawY = yy + i * rowH;
		
		draw_sprite(cost.icon, 0, drawX, drawY);
			
		drawX += iconW + gapX;
			
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

function scr_research_addResourceStruct(struct) {
	
	if (!is_struct(struct)) exit;

	var keys = variable_struct_get_names(struct);
	var len = array_length(keys);

	for (var i = 0; i < len; i++) {

		var key = keys[i];
		var amount = struct[$ key];

		scr_research_addResource(key, amount);

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

function scr_research_dataReq(level, modifier = undefined) {

	var dataReq = 800 + power(level, 2) * 80
	
	if (is_real(modifier)) dataReq = round(dataReq * modifier);
	
	return dataReq;
	
}

function scr_research_resReq(initial, level, interval = 1, modifier = undefined) {

	var amount = initial;

	var effLevel = max(0, ((level + 1) div interval) - 1);

	var pow = effLevel * effLevel;
	var dec = pow * 0.1;
	var extra = round(initial * dec);

	amount = initial + extra;

	if (is_real(modifier)) amount = round(amount * modifier);

	return amount;

}

//PROJECTS

#region //bionics
function project_vitality() : researchProject() constructor {

	name = "Vitality";
	key = "vitality";
	category = "bionics";
	icon = spr_icon_enhancedHomeostasis;

	maxLevel = 24;
	
	static setupFunc = function() {
		
		passives.maxHp = level * 10;
		if (level >= 3) passives.hpRegen = (level div 3) * 0.5;
		
		resourceCosts = {
			data: scr_research_dataReq(level),
			bio: scr_research_resReq(30, level)
		};
		
		if ((level + 1) mod 3) == 0 {
			
			resourceCosts.mutantOrgan = scr_research_resReq(16, level, 3)
			
		}
		
	}
	
	static formatDescription = function() {
	
		description = "Each level increases maximum health by 10";
		description += "\nEvery 3 levels increases health regeneration by 0.5";
		
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
		
		resourceCosts = {
			data: scr_research_dataReq(level),
			bio: scr_research_resReq(30, level)
		};
		
		if ((level + 1) mod 3) == 0 {
			
			resourceCosts.alienOrgan = scr_research_resReq(16, level, 3)
			
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
		if (level >= 12) passives.maxDashes = 1;
		
		resourceCosts = {
			data: scr_research_dataReq(level),
			bio: scr_research_resReq(30, level)
		};
		
		if ((level + 1) mod 4) == 0 {
			
			resourceCosts.fissiles = scr_research_resReq(10, level, 4)
			
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
		
		resourceCosts = {
			data: scr_research_dataReq(level),
			bio: scr_research_resReq(16, level),
			metals: scr_research_resReq(16, level)
		};
		
		if ((level + 1) mod 3) == 0 {
			
			resourceCosts.mutantOrgan = scr_research_resReq(16, level, 3)
			
		}
		
	}
	
	static formatDescription = function() {
	
		description = "Each level increases melee damage % by 3";
		description += "\nEvery 3 levels increases DA by 10";
		
	}
	
}

#endregion

#region //materials

function project_armor() : researchProject() constructor {

	name = "Armor";
	key = "armor";
	category = "materials";
	icon = spr_icon_kevlar;

	maxLevel = 24;
	
	static setupFunc = function() {
		
		passives.projRes = level;
		passives.meleeRes = level;
		if (level >= 4) passives.kinResPerc = (level div 4) * 10;
		
		resourceCosts = {
			data: scr_research_dataReq(level),
			metals: scr_research_resReq(22, level),
			polymers: scr_research_resReq(22, level)
		};
		
		if ((level + 1) mod 4) == 0 {
			
			resourceCosts.fissiles = scr_research_resReq(10, level, 4)
			
		}
		
	}
	
	static formatDescription = function() {
	
		description = "Each level increases projectile and melee resistance by 1";
		description += "\nEvery 4 levels increases kinetic resistance by 10%";
		
	}
	
}

function project_thermochemicalResistance() : researchProject() constructor {

	name = "Thermochemical Resistance";
	key = "thermochemicalResistance";
	category = "materials";
	icon = spr_icon_kevlar;

	maxLevel = 24;

	static setupFunc = function() {

		passives.chemRes = level * 2;
		passives.fireRes = level * 2;

		if (level >= 3) {
			passives.chemResPerc = (level div 3) * 5;
			passives.fireResPerc = (level div 3) * 5;
		}

		resourceCosts = {
			data: scr_research_dataReq(level),
			metals: scr_research_resReq(22, level),
			polymers: scr_research_resReq(22, level)
		};

		if ((level + 1) mod 3 == 0) {
			resourceCosts.fissiles = scr_research_resReq(8, level, 3)
		}

	}

	static formatDescription = function() {

		description = "Each level increases chemical and fire resistance by 2";
		description += "\nEvery 3 levels increases chemical and fire resistance by 5%";

	}

}

function project_energyResistance() : researchProject() constructor {

	name = "Energy Resistance";
	key = "energyResistance";
	category = "materials";
	icon = spr_icon_kevlar;

	maxLevel = 24;

	static setupFunc = function() {

		passives.elecRes = level * 2;
		passives.radRes = level * 2;

		if (level >= 3) {
			passives.elecResPerc = (level div 3) * 5;
			passives.radResPerc = (level div 3) * 5;
		}

		resourceCosts = {
			data: scr_research_dataReq(level),
			metals: scr_research_resReq(22, level),
			polymers: scr_research_resReq(22, level)
		};

		if ((level + 1) mod 3 == 0) {
			resourceCosts.fissiles = scr_research_resReq(8, level, 3)
		}

	}

	static formatDescription = function() {

		description = "Each level increases electrical and radiation resistance by 2";
		description += "\nEvery 3 levels increases electrical and radiation resistance by 5%";

	}

}

function project_chemicalAffinity() : researchProject() constructor {

	name = "Reactants";
	key = "chemicalAffinity";
	category = "materials";
	icon = spr_icon_acidFlasks;

	maxLevel = 24;

	static setupFunc = function() {

		passives.chemDamPerc = level * 3;

		if (level >= 3) {
			passives.chemResPerc = (level div 3) * 5;
		}

		resourceCosts = {
			data: scr_research_dataReq(level),
			bio: scr_research_resReq(22, level),
			polymers: scr_research_resReq(22, level)
		};

		if ((level + 1) mod 3 == 0) {
			resourceCosts.pollen = scr_research_resReq(16, level, 3);
		}

	}

	static formatDescription = function() {

		description = "Each level increases chemical damage by 3%";
		description += "\nEvery 3 levels increases chemical resistance by 5%";

	}

}

function project_fireAffinity() : researchProject() constructor {

	name = "Pyrophorics";
	key = "fireAffinity";
	category = "materials";
	icon = spr_icon_flamethrower;

	maxLevel = 24;

	static setupFunc = function() {

		passives.fireDamPerc = level * 3;

		if (level >= 3) {
			passives.fireResPerc = (level div 3) * 5;
		}

		resourceCosts = {
			data: scr_research_dataReq(level),
			bio: scr_research_resReq(22, level),
			polymers: scr_research_resReq(22, level)
		};

		if ((level + 1) mod 3 == 0) {
			resourceCosts.pollen = scr_research_resReq(16, level, 3)
		}

	}

	static formatDescription = function() {

		description = "Each level increases fire damage by 3%";
		description += "\nEvery 3 levels increases fire resistance by 5%";

	}

}

function project_alloys() : researchProject() constructor {

	name = "Alloys";
	key = "alloys";
	category = "materials";
	icon = spr_icon_kevlar;

	maxLevel = 24;

	static setupFunc = function() {

		passives.kinDamPerc = level * 3;

		if (level >= 3) {
			passives.kinResPerc = (level div 3) * 5;
		}

		resourceCosts = {
			data: scr_research_dataReq(level),
			metals: scr_research_resReq(30, level)
		};

		if ((level + 1) mod 3 == 0) {
			resourceCosts.fissiles = scr_research_resReq(8, level, 3)
		}

	}

	static formatDescription = function() {

		description = "Each level increases kinetic damage by 3%";
		description += "\nEvery 3 levels increases kinetic resistance by 5%";

	}

}

#endregion

#region // energy

function project_voltage() : researchProject() constructor {

	name = "Voltage";
	key = "voltage";
	category = "energy";
	icon = spr_icon_chainLightning;

	maxLevel = 24;

	static setupFunc = function() {

		passives.elecDamPerc = level * 3;

		if (level >= 3) {
			passives.elecResPerc = (level div 3) * 5;
		}

		resourceCosts = {
			data: scr_research_dataReq(level),
			metals: scr_research_resReq(30, level)
		};

		if ((level + 1) mod 3 == 0) {
			resourceCosts.chip = scr_research_resReq(16, level, 3)
		}

	}

	static formatDescription = function() {

		description = "Each level increases electric damage by 3%";
		description += "\nEvery 3 levels increases electric resistance by 5%";

	}

}

function project_fission() : researchProject() constructor {

	name = "Fission";
	key = "fission";
	category = "energy";
	icon = spr_icon_radioactiveBullets;

	maxLevel = 24;

	static setupFunc = function() {

		passives.radDamPerc = level * 3;

		if (level >= 3) {
			passives.radResPerc = (level div 3) * 5;
		}

		resourceCosts = {
			data: scr_research_dataReq(level),
			metals: scr_research_resReq(30, level),
			fissiles: scr_research_resReq(4, level)
		};

		if ((level + 1) mod 3 == 0) {
			resourceCosts.chip = scr_research_resReq(16, level, 3)
		}

	}

	static formatDescription = function() {

		description = "Each level increases radiation damage by 3%";
		description += "\nEvery 3 levels increases radiation resistance by 5%";

	}

}

function project_capacitance() : researchProject() constructor {

	name = "Capacitance";
	key = "capacitance";
	category = "energy";
	icon = spr_icon_energyPack;

	maxLevel = 24;

	static setupFunc = function() {

		passives.maxEnergy = 10 * level;
		
		if (level >= 3) passives.energyRegen = (level div 3) * 0.5;
		
		resourceCosts = {
			data: scr_research_dataReq(level),
			metals: scr_research_resReq(22, level),
			polymers: scr_research_resReq(22, level)
		};
		
		if ((level + 1) mod 3) == 0 {
			
			resourceCosts.chip = scr_research_resReq(16, level, 3)
			
		}
		
	}
	
	static formatDescription = function() {
	
		description = "Each level increases maximum energy by 10";
		description += "\nEvery 3 levels increases energy regeneration by 0.5";
		
	}
	
}

function project_cycling() : researchProject() constructor {

	name = "Cycling";
	key = "cycling";
	category = "energy";
	icon = spr_icon_energyPack;

	maxLevel = 24;
	
	static setupFunc = function() {
		
		passives.energyRegen = level * 0.3;
		if (level >= 3) passives.energyPackRegen = (level div 3) * 0.05;
		
		resourceCosts = {
			data: scr_research_dataReq(level),
			metals: scr_research_resReq(30, level)
		};
		
		if ((level + 1) mod 3) == 0 {
			
			resourceCosts.chip = scr_research_resReq(16, level, 3)
			
		}
		
	}
	
	static formatDescription = function() {
	
		description = "Each level increases energy regeneration by 0.3";
		description += "\nEvery 3 levels increases energy pack regen by .05";
		
	}
	
}

#endregion

