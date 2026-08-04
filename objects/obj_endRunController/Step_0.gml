if (global.devControls and keyboard_check_pressed(vk_end)) game_end();

if (keyPressDelay > 0) {
	
	keyPressDelay --;
	
} else {
	
	if (keyboard_check_pressed(vk_anykey) and tab != "loot" and tab != "reveal") tabIndex++;

}