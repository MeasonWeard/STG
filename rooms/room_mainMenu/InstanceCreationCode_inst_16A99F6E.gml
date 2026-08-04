txt = "Continue";

active = file_exists("metadata.txt") and scr_file_findExistingSave() != undefined;

leftFunc = function() {

	global.saveFile = scr_file_getLatestSave();
	global.gameData = scr_file_loadGame(global.saveFile);

	if (global.gameData == undefined) {

		var sf = scr_file_findExistingSave()
		
		if (sf == undefined) {
			
			global.saveFile = "save0";
			global.gameData = scr_file_createBlankSave();
			scr_file_saveGame("save0", global.gameData);
			
		} else {
		
			global.saveFile = sf;
			global.gameData = scr_file_loadGame(global.saveFile);
		
		}
		
	}
	
	scr_file_startGame();
	
}