#macro VERSION 0
#macro BUILD 0

randomize();

//PERSISTENT INSTANCES
global.data = scr_obj_createExclusive(obj_data, x, y);
global.display = scr_obj_createExclusive(obj_displayController, x, y);
global.cursor = scr_obj_createExclusive(obj_cursor, x, y);

global.debug = true;

//UH
window_set_cursor(cr_none);

room_goto(room_startRun);