txt = "Skip Tutorial";

leftFunc = function() {

	var startingGun = new gun_blaster(0, 1);
	
	global.gameData.playerData.weapons.weapon1 = startingGun;
	scr_data_setProgress("completedTutorial", true);
	
	scr_file_saveGame(global.saveFile, global.gameData);
	
	room_goto(stage_hub1);
	
}