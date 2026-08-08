if (tab == "main") {
	
	continueButton.active = true;
	settingsButton.active = true;
	quitButton.active = true;
	
} else {
	
	continueButton.active = false;
	settingsButton.active = false;
	quitButton.active = false;
	
}

if (tab == "quit") {
	
	yesButton.active = true;
	noButton.active = true;
	
} else {
	
	yesButton.active = false;
	noButton.active = false;
	
}

if (tab == "settings") {
	
	settingsBackButton.active = true;
	musicSlider.active = true;
	sfxSlider.active = true;
	
} else {
	
	settingsBackButton.active = false;
	musicSlider.active = false;
	sfxSlider.active = false;
	
}