global.data = self;

//display
resolutions = [];
resolutionIndex = 0;
array_push(resolutions, [1920, 1080]);
array_push(resolutions, [1664, 936]);
array_push(resolutions, [1280, 720]);
array_push(resolutions, [1024, 576]);

//settings
global.settingsDirty = false;

defaultSettings = {

	windowed: false,
	res: [1280, 720],
	
}

enum layers {
	
	physical = 0,
	decorations = 800,
	ground = 900,
	effects = -500,
	lighting = -700,
	borders = -800,
	ui = -90000
	
}

enum projectileTypes {

	normal = 0,
	blast = 1
	
}

//stages
stages = {

	def: {
	
		room: undefined,
		name: "none",
		mapCol: c_blue
	
	},

	engHall1: {
		
		room: stage_engHall1
		
	}
	
}


//LOAD GAME
global.saveFile = scr_file_getLatestSave();
global.gameData = scr_file_loadGame(global.saveFile);

if (global.gameData == undefined) {

	global.gameData = scr_file_createBlankSave();
	scr_file_saveGame("save0", global.gameData);
	
}