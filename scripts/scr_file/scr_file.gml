function scr_file_saveFile(fileName, newFile) {
	
    var json_string = json_stringify(newFile);
    var file = file_text_open_write(fileName);
	
    file_text_write_string(file, json_string);
    file_text_close(file);
	
}

function scr_file_loadFile(fileName) {
	
    var file = file_text_open_read(fileName);
    var json_string = file_text_read_string(file);
	
    file_text_close(file);

    var str = json_parse(json_string);
    return str;
	
}

function scr_file_initMetaData() {

	var metadataFile = "metadata.txt";
	
	var data = {
		latestSave: "save0"	
	};
	
	scr_file_saveFile(metadataFile, data);
	
	return data;
	
}

function scr_file_getLatestSave() {
	
	var metadataFile = "metadata.txt";

	if (!file_exists(metadataFile)) {
		
		var data = scr_file_initMetaData();
		return data.latestSave;
		
	} else {
		
		var data = scr_file_loadFile(metadataFile);
		return data.latestSave;
		
	}
	
}

function scr_file_setLatestSave(slotName) {
	
	var metadataFile = "metadata.txt";
	var metaData;

	if (file_exists(metadataFile)) {
		metaData = scr_file_loadFile(metadataFile);
	} else {
		metaData = scr_file_initMetaData();
	}

	metaData.latestSave = slotName;
	scr_file_saveFile(metadataFile, metaData);
	
}

/// @function scr_file_loadGame(saveFile)
/// @param {string} saveFile  The name of the save file, e.g. "save1.txt"
/// @returns A valid save struct (either loaded or newly created)
function scr_file_loadGame(saveFile) {
	
	if (file_exists(saveFile)) {
		
		return scr_file_loadFile(saveFile);
		
	} else {
		
		return undefined;
		
	}
	
}

function scr_file_saveGame(saveFile, saveData) {

	saveData.version = VERSION;
	saveData.build = BUILD;
	saveData.timeData.lastSave = date_current_datetime();
	scr_file_saveFile(saveFile, saveData);
	scr_file_setLatestSave(saveFile);
	
}
/// @function scr_file_createBlankSave(name)
/// @param {real} slot  The slot number
/// @returns A valid save struct
function scr_file_createBlankSave() {

	var newSave = {
		
		timeData: {
			gameStart: date_current_datetime(),
			lastSave: date_current_datetime(),
			gameSeconds: 0,
			tick: 0
		},
		
		settings: scr_data_defaultSettings(),
		
		playerData: {
		
			name: undefined,
			avatar: undefined,
			
			class1: undefined,
			class2: undefined,
			
			xp: 0,
			level: 0,
			
			gear: {

				device1: undefined,
				device2: undefined,
				tie: undefined,
				headgear: undefined
	
			},
				
		},
		
		inventory: {
			devices: [],
			ties: [],
			headgear: [],
			guns: [],
			melee: []
		},
		
		resources: {},
		
	};
	
	return newSave;
	
}

/// @func scr_file_getTextFromFile(filename)
/// @desc Loads an entire text file and returns its contents as a string.
/// @param {string} filename - Name of the text file (must be in included files or local directory)
///
/// @return {string} File contents, or "" if not found.
function scr_file_getTextFromFile(filename) {

	if(!is_string(filename)) return "invalid file path";

    var path = "text/" + filename + ".txt";

    // If it's not an absolute path, look in included files or local working directory
    if (!file_exists(path)) {
        show_debug_message("File not found: " + string(path));
        return "";
    }

    var file = file_text_open_read(path);
    var text = "";

    while (!file_text_eof(file)) {
        var line = file_text_read_string(file);
        file_text_readln(file); // move to next line
        text += line + "\n";
    }

    file_text_close(file);
    return text;
	
}
