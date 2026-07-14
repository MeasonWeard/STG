if (tabIndex >= array_length(tabs) or tab == "continue") {
	
	game_end();
	
} else {

	if (tab != "reveal") tab = tabs[tabIndex];

}