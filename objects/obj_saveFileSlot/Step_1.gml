if (initialLoad) {

	initialLoad = false;
	
	saveFile = scr_file_loadFile(path);
	
	if (is_struct(saveFile)) {
	
		time = date_time_string(saveFile.timeData.lastSave);
		name = saveFile.playerData.name;
		level = string(saveFile.playerData.level);
		
		fileLoaded = true;
		
	}
	
}

mode = global.selectSaveController.mode;