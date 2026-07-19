global.skillsMainMenuController.class1Button = self;
font = fnt_large;
active = false;

leftFunc = function() {

	var class = global.gameData.playerData.class1;
	global.selectedClass = class;
	
	if (class.id == classes.physics) room_goto(room_physics);
	if (class.id == classes.chemistry) room_goto(room_chemistry);
	if (class.id == classes.biology) room_goto(room_biology);
	if (class.id == classes.engineering) room_goto(room_engineering);
	
}