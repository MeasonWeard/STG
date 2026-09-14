global.researchController = self;

var playerData = global.gameData.playerData;

if (!variable_struct_exists(playerData, "research")) playerData.research = {};
if (is_undefined(playerData.research)) playerData.research = {};
if (!variable_struct_exists(playerData.research, "currentResearch")) playerData.research.currentResearch = undefined;

research = playerData.research;

if (!variable_struct_exists(research, "meta")) research.meta = {

	projects: {},
	selected: undefined

};

if (!variable_struct_exists(research, "survival")) research.survival = {

	projects: {},
	selected: undefined

};

if (!variable_struct_exists(research, "combat")) research.combat = {

	projects: {},
	selected: undefined

};

if (!variable_struct_exists(research, "utility")) research.utility = {

	projects: {},
	selected: undefined

};