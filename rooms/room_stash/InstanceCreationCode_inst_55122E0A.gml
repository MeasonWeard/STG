txt = "Back";

leftFunc = function() {

	global.gameData.playerData.gear = global.stashController.equippedGear;
	global.gameData.playerData.weapons = global.stashController.equippedWeapons;
	
	scr_file_saveGame(global.saveFile, global.gameData);
	
	room_goto(stage_hub1);
	
}