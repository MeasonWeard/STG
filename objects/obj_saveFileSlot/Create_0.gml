path = undefined;
saveFile = undefined;
initialLoad = true;
fileLoaded = false;

mode = "select";
deleting = false;

//interaction
mouseHover = false;

loadFile = function() {

	global.saveFile = path;
	global.gameData = saveFile;
	
	scr_file_startGame();
	
}

deleteFile = function() {
	
	with(obj_saveFileSlot) {
		
		deleting = false;	
		
	}
	
	deleting = !deleting;
	
}

createNew = function() {

	global.saveFile = path;
	global.gameData = scr_file_createBlankSave();
	
	room_goto(room_classSelect);
	
}

//data
name = "";
time = "";
level = "";
class1 = "(not selected yet)";
class2 = "(not selected yet)";

//formatting
textX = x + 12;
textY = y + 32;