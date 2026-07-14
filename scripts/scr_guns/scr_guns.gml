function gunInst(level, rarity) : weaponInst(level, rarity) constructor {

	//appearance and sound
	shootSounds = global.data.soundProfiles.blaster;
	reloadSound = undefined;
	projSprite = spr_bullet1;
	spr = spr_gun;
	description = undefined;
	
	//attack
	auto = true;
	projectileType = projectileTypes.normal;
	fireRate = 8;
	blastProjectiles = 5;
	blastSpread = 10;
	spd = 22;
	range = 1600;
	collisionFunc = undefined;

	//aim
	minAimOff = 2;
	maxAimOff = 6;
	recoil = 0.8;
	stability = 0.1;
		
	//ammo
	clipSize = 45;
	ammo = 45;
	reloadTime = 2.2;
	
	//runtime data
	aimOff = 0;
	fireTick = 0;
	reload = 0;
	temporary = false;
		
}

function scr_guns_shoot(char) {
	
	if (!instance_exists(char)) return noone;
	if (!is_instanceof(char.equippedWeapon, gunInst)) return noone;
	
	var gun = char.equippedWeapon;
	var weaponStats = char.equippedWeaponStats;
	var proj = noone;
	
	if (gun.ammo > 0 and gun.fireTick <= 0) {
		
		proj = scr_projectiles_shoot(char);

		if (proj == noone) return noone;
		
		var profile = weaponStats.shootSounds;
		var snd = scr_audio_randomSoundFromProfile(profile);
		if (snd != undefined) audio_play_sound_at(snd, char.x, char.y, 0, 200, 1600, 1, false, 0);
		
		gun.fireTick = 60 / weaponStats.fireRate;
		
		gun.ammo --;
		
		if (gun.ammo < 1) {
			
			if (gun.temporary) {
			
				var len = array_length(char.weapons);
				
				for (var i = 0; i < len; i ++) {
				
					var thisGun = weapons[i].gun;
					if (thisGun == gun) array_delete(char.weapons, i, 1);
					char.weaponIndex --;
					
				}
			
			} else {
			
				gun.reload = weaponStats.reloadTime * 60;
			
			}
			
		}
		
	}
	
	return proj;

}

function scr_guns_reloadSlot(char, slot) {

    if (!instance_exists(char)) return false;
    if (!is_struct(slot)) return false;

    var gun = slot.weapon;
    var weaponStats = slot.stats;

    if (!is_instanceof(gun, gunInst)) return false;
    if (!is_struct(weaponStats)) return false;

    if (gun.ammo == weaponStats.clipSize) return false;

    gun.ammo = 0;
    gun.reload = weaponStats.reloadTime * 60;

    return true;

}

function scr_guns_reloadCurrent(char) {

    if (!instance_exists(char)) return false;

    var len = array_length(char.weapons);
    if (char.weaponIndex < 0 or char.weaponIndex >= len) return false;

    return scr_guns_reloadSlot(char, char.weapons[char.weaponIndex]);

}



function scr_guns_calculateGunStats(char, gun) {

	if (!instance_exists(char)) return undefined;
	if (!is_instanceof(gun, gunInst)) return undefined;

	var newStats = scr_stats_calculateDamageProfileWeapon(char, gun);

	return newStats;
	
}

function scr_guns_formatDescription(gun) {
	return "";
}