// Inherit the parent event
event_inherited();

weapon = noone;

collectSounds = [snd_collectGun];

collectFunc = function(char, item) {
	
	if (is_instanceof(item.weapon, weaponInst)) {
	
		scr_weapons_collectWeapon(char, item.weapon, true);
	
	}
	
}

maxPullRange = 75;