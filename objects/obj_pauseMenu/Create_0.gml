tab = "main";
settingsVersion = 0;

//formatting
cam = view_camera[0];
camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);
camH = camera_get_view_height(cam)
camW = camera_get_view_width(cam);
camXmid = camX + camW * 0.5;
camYmid = camY + camH * 0.5;

buttonGap = 128;
optionsGap = 64;
topButtonY = 200;

txtY = camYmid - 364;

//functions
play = function() {

	global.stageController.pause();
	
}

settings = function() {

	tab = "settings";
	
	with (obj_slider) {
		delay = 18;	
	}
	
	with (obj_checkBox) {
		delay = 18;	
	}
	
	with (obj_optionSelector) {
		delay = 18;
	}
	
}

quit = function() {

	tab = "quit";
	
}

yes = function() {

	instance_activate_all();
	scr_stages_endRun();
	
}

no = function() {

	tab = "main";
	
}

saveSettings = function() {

	scr_file_saveGame(global.saveFile, global.gameData);
	tab = "main";
	
}

//buttons
continueButton = instance_create_layer(x, y, "Instances", obj_buttonRectangleLarge);
settingsButton = instance_create_layer(x, y, "Instances", obj_buttonRectangleLarge);
quitButton = instance_create_layer(x, y, "Instances", obj_buttonRectangleLarge);
yesButton = instance_create_layer(x, y, "Instances", obj_buttonRectangleLarge);
noButton = instance_create_layer(x, y, "Instances", obj_buttonRectangleLarge);
settingsBackButton = instance_create_layer(x, y, "Instances", obj_buttonRectangleLarge);

continueButton.x = camXmid;
continueButton.y = camYmid - 128;
continueButton.txt = "Continue";
continueButton.visibleWhenInactive = false;
continueButton.leftFunc = play;

settingsButton.x = camXmid;
settingsButton.y = continueButton.y + buttonGap;
settingsButton.txt = "Settings";
settingsButton.visibleWhenInactive = false;
settingsButton.leftFunc = settings;

quitButton.x = camXmid;
quitButton.y = settingsButton.y + buttonGap;
quitButton.txt = "Quit Run";
quitButton.visibleWhenInactive = false;
quitButton.leftFunc = quit;

yesButton.x = camXmid;
yesButton.y = settingsButton.y;
yesButton.txt = "Yes";
yesButton.active = false
yesButton.visibleWhenInactive = false;
yesButton.leftFunc = yes;

noButton.x = camXmid;
noButton.y = yesButton.y + buttonGap;
noButton.txt = "No";
noButton.active = false
noButton.visibleWhenInactive = false;
noButton.leftFunc = no;

//settings
settingsBackButton.x = continueButton.x;
settingsBackButton.y = continueButton.y - buttonGap;
settingsBackButton.txt = "Back";
settingsBackButton.active = false
settingsBackButton.visibleWhenInactive = false;
settingsBackButton.leftFunc = saveSettings;

musicSlider = instance_create_layer(x, y, "Instances", obj_slider);
musicSlider.active = false;
musicSlider.x = camXmid - 100;
musicSlider.y = continueButton.y + optionsGap;
musicSlider.text = "Music Volume";
musicSlider.setting = "musicVolume";
musicSlider.minValue = 0;
musicSlider.maxValue = 1;

sfxSlider = instance_create_layer(x, y, "Instances", obj_slider);
sfxSlider.active = false;
sfxSlider.x = camXmid - 100;
sfxSlider.y = musicSlider.y + optionsGap;
sfxSlider.text = "SFX Volume";
sfxSlider.setting = "sfxVolume";
sfxSlider.minValue = 0;
sfxSlider.maxValue = 1;

fullscreen = instance_create_layer(x, y, "Instances", obj_checkBox);
fullscreen.setting = "fullscreen";
fullscreen.text = "Full screen";
fullscreen.x = camXmid - 100;
fullscreen.y = sfxSlider.y + optionsGap;
fullscreen.active = false;

resolution = instance_create_layer(x, y, "Instances", obj_optionSelector);
resolution.options = global.data.resolutions;
resolution.text = "Windowed resolution";
resolution.setting = "resIndex";
resolution.x = camXmid - 100;
resolution.y = fullscreen.y + optionsGap;
resolution.active = false;

showAmmo = instance_create_layer(x, y, "Instances", obj_optionSelector);
showAmmo.options = ["Cursor and HUD","HUD","Cursor"];
showAmmo.text = "Show ammo/charges on";
showAmmo.setting = "showAmmo";
showAmmo.x = camXmid - 100;
showAmmo.y = resolution.y + optionsGap;
showAmmo.active = false;

showReload = instance_create_layer(x, y, "Instances", obj_checkBox);
showReload.setting = "showReloadOnCursor";
showReload.text = "Show reload on cursor";
showReload.x = camXmid - 100;
showReload.y = showAmmo.y + optionsGap;
showReload.active = false;

showName = instance_create_layer(x, y, "Instances", obj_checkBox);
showName.setting = "alwaysShowWeaponName";
showName.text = "Always show weapon name on cursor";
showName.x = camXmid - 100;
showName.y = showReload.y + optionsGap;
showName.active = false;

showSkills = instance_create_layer(x, y, "Instances", obj_checkBox);
showSkills.setting = "showSkillsOnCursor";
showSkills.text = "Show skills on cursor";
showSkills.x = camXmid - 100;
showSkills.y = showName.y + optionsGap;
showSkills.active = false;