function gunInst(level, rarity) : weaponInst(level, rarity) constructor {

	type = itemTypes.gun;

	//appearance and sound
	shootSounds = global.data.soundProfiles.blaster;
	reloadSound = undefined;
	projSprite = spr_bulletNormal;
	projDestroySprite = spr_bulletExplosion;
	projImageSpeed = 1;
	projSubimage = 0;
	lockProjSprite = false;
	spr = spr_blaster;
	description = undefined;
	rot = 0;
	
	//attack
	auto = true;
	projectileType = projectileTypes.normal;
	fireRate = 8;
	blastProjectiles = 5;
	blastSpread = 10;
	spd = 22;
	range = 1200;
	collisionFuncs = undefined;

	//aim
	minAimOff = 2;
	maxAimOff = 6;
	recoil = 0.8;
	stability = 0.1;
		
	//ammo
	clipSize = 24;
	reloadTime = 2.2;
	
	//runtime data
	ammo = 24;
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
			
				gun.reload = max(0.01, weaponStats.reloadTime * 60);
			
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
	
	var bonusStats  = gun.bonusStats;
	var keys = variable_struct_get_names(bonusStats);
	var keysLen = array_length(keys);
	
	for (var i = 0; i < keysLen; i ++) {
		
		var key = keys[i];
		var amount = bonusStats[$ key];
		
		scr_stats_alterStat(newStats, key, amount);
		
	}
	
	if (char.stats.gunDamPerc > 0) {
		var dec = 1 + char.stats.gunDamPerc * 0.01;
		newStats.damage = scr_stats_multiplyDamageProfile(newStats.damage, dec);
	}
	
	//projectile
	if (!gun.lockProjSprite) {
		
		gun.projImageSpeed = 0;
		gun.projSubimage = scr_guns_projectileSubimage(gun)
	
	}

	return newStats;
	
}

function scr_guns_formatDescription(gun) {

	if (!is_instanceof(gun, gunInst)) return undefined;

	var stats = gun.bonusStats;
	var damage = gun.damage;
	
	var txt = gun.name + "     " + "lvl " + string(gun.lvl);
	var damageTxt = scr_stats_formatDamage(damage);
	
	var projType = gun.projectileType;
	var clipSize = gun.clipSize;
	var fireRate = string_trimDecimals(gun.fireRate, 2);
	var reloadTime = string_trimDecimals(gun.reloadTime, 2);
	var range = gun.range;
	var minAim = gun.minAimOff;
	var maxAim = gun.maxAimOff;
	var stability = gun.stability;
	var recoil = string_trimDecimals(gun.recoil, 2);
	
	txt += "\n\nBasics\n----------------\n"
	txt += "Ammo: " + string(clipSize);
	txt += "\nFire Rate: " + string(fireRate) + " p/s";
	txt += "\nReload time: " + string(reloadTime) + " seconds";
	txt += "\nRange: " + string(range);
	
	if (projType = projectileTypes.normal) {
		
		var spread = minAim + maxAim * 0.05;
		var accuracy = string_trimDecimals(100 / spread, 1);
		var control = string_trimDecimals(stability * 10, 1);
		
		txt += "\n\nAccuracy: " + string(accuracy);
		txt += "\nRecoil: " + string(recoil);
		txt += "\nControl: " + string(control);
		
	}
	
	if (projType == projectileTypes.blast) {
		
		var projectiles = gun.blastProjectiles;
		var	blastSpread = gun.blastSpread;	
		
		txt += "\n\nProjectiles: " + string(projectiles);
		txt += "\nSpread: " + string(blastSpread) + " degrees";
		
	}
	
	txt += "\n\nDamage\n----------------\n";
	
	txt += damageTxt;
	
	var keys = variable_struct_get_names(stats);
	var keysLen = array_length(keys);
	
	if (keysLen > 0) txt += "\n\nBonus\n----------------";
	
	for (var i = 0; i < keysLen; i ++) {
	
		var stat = keys[i];
		var val = stats[$ stat];
	
		if (val == 0) continue;
		
		var newText = scr_stats_getName(stat);
		newText += ": " + string(val);
		
		txt += "\n";

		txt += newText;
	
	}
	
	return txt;
	
}

function scr_guns_projectileSubimage(gun) {

	if (!is_instanceof(gun, gunInst)) return 0;

	var el = undefined;
	
	var highest = scr_weapons_getTop2DamageTypes(gun, false);
	var len = array_length(highest);
	
	if (len < 1) {
		
		return 0;
		
	} else if (len == 1) {
		
		el = highest[0].key;
		
	} else if (len > 1) {
		
		var first = highest[0];
		var second = highest[1];
		
		var type1 = first.key;
		var type2 = second.key;
		
		var val1 = first.val;
		var val2 = second.val
		
		el = type1;
		
		show_debug_message(type1);
		show_debug_message(type2);
		
		if (type1 == "kin") {
			
			if (val2 > val1 * 0.25) el = type2;
			
		}
		
	}
	
	var subImage = 0;
	
	switch(el) {
	
		case "kin": subImage = 0; break;
		case "fire": subImage = 1; break;
		case "chem": subImage = 2; break;
		case "elec": subImage = 3; break;
		case "rad": subImage = 4; break;
		
	}
	
	return subImage;
	
}