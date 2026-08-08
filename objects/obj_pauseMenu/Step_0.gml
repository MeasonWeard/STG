if (settingsVersion != global.settingsVersion) {

	settingsVersion = global.settingsVersion;

	var fullscreen = scr_data_getSetting("fullscreen", false);

	if (fullscreen) {
		
		scr_display_setFullscreenOn();	
		
	} else {
		
		scr_display_setFullscreenOff();
		
	}

	scr_display_changeResolution();
	
}