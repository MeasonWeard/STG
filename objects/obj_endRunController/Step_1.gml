if (tabIndex >= array_length(tabs) or tab == "continue") {
	
	tab = "continue";
	
	if (returnToHubTick > 0) {
		
		returnToHubTick --;	
		
	} else {
		
		finish();
		
	}
	
} else {

	if (tab != "reveal") tab = tabs[tabIndex];

}