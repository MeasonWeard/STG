txt = "Back";

leftFunc = function() {

	scr_file_saveGame(global.saveFile, global.gameData);
	room_goto(room_mainMenu);
	
}