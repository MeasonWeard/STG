event_inherited();

useFunc = function() {
	
	if (instance_exists(global.player)) instance_destroy(global.player);
	scr_char_removeAllPets();
	
	room_goto(room_research);

}