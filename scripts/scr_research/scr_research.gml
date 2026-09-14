function researchProject(_key) constructor {

	key = _key;
	name = "none";
	icon = spr_icon_energyPack;
	
	category = "meta";

	level = 0;
	maxLevel = 5;

	progress = 0;
	lastCleared = undefined;

	passives = {};
	resourceCosts = {
		data: 100	
	}
	
	requiredResearch = ["fixResearchStation"];

	static setupFunc = function() {};
	static formatDescription = function() {};
	
}

function scr_research_loadProject(savedProject) {

	var const = variable_struct_get(
		global.data.researchConstructors,
		savedProject.key
	);

	if (is_undefined(const)) return undefined;

	if (is_instanceof(savedProject, const)) return savedProject;

	var loadedProject = new const();

	loadedProject.level = savedProject.level;
	loadedProject.progress = savedProject.progress;
	loadedProject.lastCleared = savedProject.lastCleared;

	return loadedProject;

}

function project_fixResearchStation() : researchProject("fixResearchStation") constructor {

	name = "Repair Research Station";
	category = "meta";
	
	requiredResearch = [];
	
	static setupFunc = function() {
		
		passives = {};
		
		resourceCosts = {
			metals: 100,
			polymers: 50,
			fissiles: 1
		};
		
	}
	
	static formatDescription = function() {
		
		return "Repairs the Research Station and unlocks further research.";
		
	}
	
}

function project_vitality() : researchProject("vitality") constructor {

	name = "Vitality";
	category = "survival";
	
	static setupFunc = function() {
		
		passives.maxHp = level * 25;
		
		resourceCosts = {
			data: 100 + level * 50
		};
		
	}
	
	static formatDescription = function() {
		
		return "Increases Maximum Health.";
		
	}
	
}

function project_shielding() : researchProject("shielding") constructor {

	name = "Shielding";
	category = "survival";
	
	static setupFunc = function() {
		
		passives.maxShield = level * 20;
		
		resourceCosts = {
			data: 100 + level * 50
		};
		
	}
	
	static formatDescription = function() {
		
		return "Increases Maximum Shield.";
		
	}
	
}


//COMBAT

function project_targeting() : researchProject("targeting") constructor {

	name = "Targeting";
	category = "combat";
	
	static setupFunc = function() {
		
		passives.oa = level * 10;
		
		resourceCosts = {
			data: 100 + level * 50
		};
		
	}
	
	static formatDescription = function() {
		
		return "Increases Offensive Ability.";
		
	}
	
}

function project_ballistics() : researchProject("ballistics") constructor {

	name = "Ballistics";
	category = "combat";
	
	static setupFunc = function() {
		
		passives.gunDamPerc = level * 5;
		
		resourceCosts = {
			data: 100 + level * 50
		};
		
	}
	
	static formatDescription = function() {
		
		return "Increases Gun Damage.";
		
	}
	
}


//UTILITY

function project_conditioning() : researchProject("conditioning") constructor {

	name = "Conditioning";
	category = "utility";
	
	static setupFunc = function() {
		
		passives.spd = level * 5;
		
		resourceCosts = {
			data: 100 + level * 50
		};
		
	}
	
	static formatDescription = function() {
		
		return "Increases Movement Speed.";
		
	}
	
}

function project_energyRecovery() : researchProject("energyRecovery") constructor {

	name = "Energy Recovery";
	category = "utility";
	
	static setupFunc = function() {
		
		passives.energyRegen = level * 0.05;
		
		resourceCosts = {
			data: 100 + level * 50
		};
		
	}
	
	static formatDescription = function() {
		
		return "Increases Energy Regeneration.";
		
	}
	
}