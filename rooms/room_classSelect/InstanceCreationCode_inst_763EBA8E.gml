txt = "Continue";

active = false;

leftFunc = function() {

	var c = global.classSelectController;
	var selectedClass = c.selectedClass;
	
	if (is_undefined(selectedClass)) exit;
	
	var class = undefined;
	
	if (selectedClass == classes.physics) class = new class_physics();
	if (selectedClass == classes.chemistry) class = new class_chemistry();
	if (selectedClass == classes.biology) class = new class_biology();
	if (selectedClass == classes.engineering) class = new class_engineering();
	
	global.gameData.playerData.class1 = class;
	
	scr_file_saveGame(global.saveFile, global.gameData);
	
	room_goto(stage_hub1);
	
}

constantFunc = function() {
	
	active = global.classSelectController.selectedClass != undefined;
	
}