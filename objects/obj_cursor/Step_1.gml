if (variable_global_exists("player")) {

	if (instance_exists(global.player)) player = global.player;

}

if (settingsVersion != global.settingsVersion) {

	settingsVersion = global.settingsVersion;

	var ammoSetting = scr_data_getSetting("showAmmo", 1);

	showAmmo = ammoSetting == 0 or ammoSetting == 2 ? true : false;
	showReload = scr_data_getSetting("showReloadOnCursor", true);
	alwaysShowName = scr_data_getSetting("alwaysShowWeaponName", false);
	
}

if (instance_exists(player)) {
	
	if (prevWeapon != player.equippedWeapon) {

		gunNameTick = 120;
	
	}

	prevWeapon = player.equippedWeapon;

} else {

	gunNameTick = 0;
	
}

sc = instance_exists(global.stageController) ? global.stageController : noone;
