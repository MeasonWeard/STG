if (variable_global_exists("player")) {

	if (instance_exists(global.player)) player = global.player;

}

if (global.settingsDirty) {

	showMelee = scr_data_getSetting("showMeleeOnCursor", true);
	showSkills = scr_data_getSetting("showSkillsOnCursor", true);
	showReload = scr_data_getSetting("showSkillsOnCursor", true);
	showAmmo = scr_data_getSetting("showAmmoOnCursor", true);
	
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
