scr_obj_mouseHover();

var loadOrDelete = mode == "select" ? loadFile : deleteFile;
var newOrNothing = mode == "select" ? createNew : undefined;

var clickFunc = fileLoaded? loadOrDelete: newOrNothing;

if (mouseHover and mouse_check_button_pressed(mb_left)) {

	if (is_callable(clickFunc))	clickFunc();

}

if (mode == "select") deleting = false;

if (deleting) {

	if (keyboard_check_pressed(vk_delete)) {
	
		file_delete(path);
		saveFile = undefined;
		fileLoaded = false;
		deleting = false;
		
		global.selectSaveController.mode = "select";
	
	}
	
}