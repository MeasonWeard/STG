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
	
	class.classNum = c.classNum;
	
	if (c.classNum == 1) global.gameData.playerData.class1 = class;
	if (c.classNum == 2) global.gameData.playerData.class2 = class;
	
	scr_file_saveGame(global.saveFile, global.gameData);
	
	if (c.classNum == 1) {
		
		room_goto(room_chooseTutorial);
		
	} else {
		
		if (selectedClass == classes.physics) room_goto(room_physics);
		if (selectedClass == classes.chemistry) room_goto(room_chemistry);
		if (selectedClass == classes.biology) room_goto(room_biology);
		if (selectedClass == classes.engineering) room_goto(room_engineering);
		
	}
	
	
}

constantFunc = function() {
	
	active = global.classSelectController.selectedClass != undefined;
	
}