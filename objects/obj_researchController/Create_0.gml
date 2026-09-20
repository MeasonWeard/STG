global.researchController = self;

//set up data
gameData = global.gameData;

if (!variable_struct_exists(gameData, "research")) gameData.research = {};
if (is_undefined(gameData.research)) gameData.research = {};
if (!variable_struct_exists(gameData.research, "currentResearch")) gameData.research.currentResearch = undefined;
if (!variable_struct_exists(gameData.research, "categories")) gameData.research.categories = {};

research = gameData.research;
categories = research.categories;

if (!variable_struct_exists(categories, "meta")) categories.meta = {

	projects: {},
	selected: undefined

};

if (!variable_struct_exists(categories, "bionics")) categories.bionics = {

	projects: {},
	selected: undefined

};

if (!variable_struct_exists(categories, "materials")) categories.materials = {

	projects: {},
	selected: undefined

};

if (!variable_struct_exists(categories, "energy")) categories.energy = {

	projects: {},
	selected: undefined

};

if (!variable_struct_exists(categories, "systems")) categories.systems = {

	projects: {},
	selected: undefined

};

//
delay = 2;
setupViewedNode = true;
viewedNode = noone;
viewedProject = undefined;
panel = noone;

currentProjectKey = undefined;
currentProject = undefined;
prevCurrentProjectKey = undefined;

reset = function() {

	var rc = global.researchController;

	with (obj_researchNode) {
			
		setup = true;
		desc = undefined;
		costs = undefined;

	}
			
	rc.delay = 2;
	rc.panel.delay = 2;
	rc.prevCurrentProjectKey = undefined;
	rc.panel.prevCurrentProject = undefined;
	rc.panel.currentProject = undefined;

}