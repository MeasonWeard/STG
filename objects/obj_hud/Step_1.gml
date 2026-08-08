//get settings
if (settingsVersion != global.settingsVersion) {

	settingsVersion = global.settingsVersion;

	var ammoSetting = scr_data_getSetting("showAmmo", 0);
	showAmmo = ammoSetting == 0 or ammoSetting == 1 ? true : false;
	
}