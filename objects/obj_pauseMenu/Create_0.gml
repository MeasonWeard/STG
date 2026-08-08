tab = "main";

//formatting
cam = view_camera[0];
camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);
camH = camera_get_view_height(cam)
camW = camera_get_view_width(cam);
camXmid = camX + camW * 0.5;
camYmid = camY + camH * 0.5;

buttonGap = 128;
topButtonY = 200;

txtY = camYmid - 364;

//functions
play = function() {

	global.stageController.pause();
	
}

settings = function() {

	tab = "settings";
	
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
settingsBackButton.y = continueButton.y;
settingsBackButton.txt = "Back";
settingsBackButton.active = false
settingsBackButton.visibleWhenInactive = false;
settingsBackButton.leftFunc = saveSettings;

musicSlider = instance_create_layer(x, y, "Instances", obj_slider);
musicSlider.active = false;
musicSlider.x = camXmid - 100;
musicSlider.y = continueButton.y + buttonGap;
musicSlider.text = "Music Volume";
musicSlider.setting = "musicVolume";
musicSlider.minValue = 0;
musicSlider.maxValue = 1;

sfxSlider = instance_create_layer(x, y, "Instances", obj_slider);
sfxSlider.active = false;
sfxSlider.x = camXmid - 100;
sfxSlider.y = continueButton.y + buttonGap * 2;
sfxSlider.text = "SFX Volume";
sfxSlider.setting = "sfxVolume";
sfxSlider.minValue = 0;
sfxSlider.maxValue = 1;