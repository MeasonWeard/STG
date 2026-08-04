if (initialLoad) {

	initialLoad = false;
	
	saveFile = scr_file_loadFile(path);
	
	if (is_struct(saveFile)) {
	
		var playerData = saveFile.playerData;
	
		time = date_datetime_string(saveFile.timeData.lastSave);
		name = playerData.name;
		level = string(playerData.level);
		
		if (is_struct(playerData.class1)) {
			class1 = playerData.class1.name;	
		}
		
		if (is_struct(playerData.class2)) {
			class2 = playerData.class2.name;	
		}
		
		fileLoaded = true;
		
	}
	
}

mode = global.selectSaveController.mode;