if (keyboard_check_pressed(vk_tab)) {

	tabIndex ++;
	if (tabIndex >= array_length(tabs)) tabIndex = 0;
	tab = tabs[tabIndex];
	
}