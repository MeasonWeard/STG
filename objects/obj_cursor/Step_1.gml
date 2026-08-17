if (variable_global_exists("player")) {

	if (instance_exists(global.player)) player = global.player;

}

if (settingsVersion != global.settingsVersion) {

	settingsVersion = global.settingsVersion;

	var ammoSetting = scr_data_getSetting("showAmmo", 1);

	showAmmo = ammoSetting == 0 or ammoSetting == 2 ? true : false;
	showReload = scr_data_getSetting("showReloadOnCursor", true);
	alwaysShowName = scr_data_getSetting("alwaysShowWeaponName", false);
	showSkillsOnCursor = scr_data_getSetting("showSkillsOnCursor", false);
	
}

if (instance_exists(player)) {
	
	if (prevWeapon != player.equippedWeapon) {

		gunNameTick = 120;
	
	}

	prevWeapon = player.equippedWeapon;
	
	if (showSkillsOnCursor) {
		
		skill1 = player.skills.skill1;
		skill2 = player.skills.skill2;
		skill3 = player.skills.skill3;
		skill4 = player.skills.skill4;
		
	}

} else {

	gunNameTick = 0;
	
	skill1 = undefined;
	skill2 = undefined;
	skill3 = undefined;
	skill4 = undefined;
	
}

sc = instance_exists(global.stageController) ? global.stageController : noone;
