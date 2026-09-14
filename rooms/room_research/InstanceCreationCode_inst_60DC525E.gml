txt = "Back";
leftKey = vk_escape;

leftFunc = function() {

	room_goto(stage_hub1);
	
	global.gameData.playerData.research = global.researchController.research;
	
	scr_file_saveGame(global.saveFile, global.gameData);
	
}