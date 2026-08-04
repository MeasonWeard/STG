#macro VERSION 0
#macro BUILD 0

randomize();

//PERSISTENT INSTANCES
global.freshSave = false;

global.data = scr_obj_createExclusive(obj_data, x, y);
global.display = scr_obj_createExclusive(obj_displayController, x, y);
global.cursor = scr_obj_createExclusive(obj_cursor, x, y);
global.audioController = scr_obj_createExclusive(obj_audioController, x, y);
global.player = noone;

global.debug = false;
global.devControls = true;

global.stageController = noone;
global.runController = noone;
global.startRun = noone;

global.hubPosX = 500;
global.hubPosY = 500;

global.selectedZone = undefined;
global.selectedClass = undefined;

global.lastWeaponIndex = 0;

//UH
window_set_cursor(cr_none);

draw_set_font(fnt_normal);

//
if (global.freshSave) {
	
	var ex = scr_file_findExistingSave();
	
	if (ex == undefined) {
	
		room_goto(room_classSelect);
	
	} else {
	
		room_goto(room_selectSaveFile);
	
	}
	
} else {

	room_goto(room_mainMenu);
	
}