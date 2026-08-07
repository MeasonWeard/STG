keyDelay = max(keyDelay - 1, 0);

if (keyboard_check_pressed(vk_escape) and keyDelay == 0) instance_destroy();

if (keyboard_check_pressed(vk_tab) and keyDelay == 0) {

	tabIndex ++;
	if (tabIndex >= array_length(tabs)) tabIndex = 0;
	tab = tabs[tabIndex];
	
}