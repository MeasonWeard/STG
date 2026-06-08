function scr_guns_createGun(name) {

	//DO NOT CHANGE VALUES. THIS IS BEING USED FOR THE BASIC BLASET
	//ALTER OTHER GUN VALUES WHEN NEEDED
	var gun = {
		
		//appearance and sound
		name: name,
		shootSounds: global.data.soundProfiles.blaster,
		reloadSound: undefined,
		projSprite: spr_bullet1,
		
		//attack
		auto: true,
		projectileType: projectileTypes.normal,
		fireRate: 12,
		
		blastProjectiles: 5,
		blastSpread: 10,
		
		damage: {
			kin: 12,
			fire: 0,
			chem: 0,
			elec: 0,
			rad: 0
		},
		
		spd: 22,
		range: 1600,
		collisionFunc: undefined,
		
		//aim
		minAimOff: 2,
		maxAimOff: 6,
		recoil: 0.8,
		stability: 0.1,
		
		//ammo
		clipSize: 45,
		ammo: 45,
		reloadTime: 2.2,
	
		//runtime data
		aimOff: 0,
		fireTick: 0,
		reload: 0,
		temporary: false
	
	}
	
	return gun;
	
}

function scr_guns_shoot(char) {
	
	if (!instance_exists(char)) return noone;
	if (!is_struct(char.gun)) return noone;
	
	var gun = char.gun;
	var gunStats = char.gunStats;
	var proj = noone;
	
	if (gun.ammo > 0 and gun.fireTick <= 0) {
		
		proj = scr_projectiles_shoot(char);

		if (proj == noone) return noone;
		
		var profile = gunStats.shootSounds;
		var snd = scr_audio_randomSoundFromProfile(profile);
		if (snd != undefined) audio_play_sound_at(snd, char.x, char.y, 0, 200, 1600, 1, false, 0);
		
		gun.fireTick = 60 / gunStats.fireRate;
		
		gun.ammo --;
		
		if (gun.ammo < 1) {
			
			if (gun.temporary) {
			
				var len = array_length(char.guns);
				
				for (var i = 0; i < len; i ++) {
				
					var thisGun = guns[i].gun;
					if (thisGun == gun) array_delete(char.guns, i, 1);
					char.gunIndex --;
					
				}
			
			} else {
			
				gun.reload = gunStats.reloadTime * 60;
			
			}
			
		}
		
	}
	
	return proj;

}

function scr_guns_reloadSlot(char, slot) {

    if (!instance_exists(char)) return false;
    if (!is_struct(slot)) return false;

    var gun = slot.gun;
    var gunStats = slot.stats;

    if (!is_struct(gun)) return false;
    if (!is_struct(gunStats)) return false;

    if (gun.ammo == gunStats.clipSize) return false;

    gun.ammo = 0;
    gun.reload = gunStats.reloadTime * 60;

    return true;

}

function scr_guns_reloadCurrent(char) {

    if (!instance_exists(char)) return false;

    var len = array_length(char.guns);
    if (char.gunIndex < 0 or char.gunIndex >= len) return false;

    return scr_guns_reloadSlot(char, char.guns[char.gunIndex]);

}

//function scr_guns_reload(gun) {

//	if (!is_struct(gun)) return false;
//	if (gun.ammo == gun.clipSize) return false;

//	gun.ammo = 0;
//	gun.reload = gun.reloadTime * 60;
	
//	return true;
	
//}

function scr_guns_collectGun(char, gun, equip) {
	
	if (!instance_exists(char)) exit;
    
    gun.ammo = gun.clipSize;
    
    var slot = {
        gun: gun,
        stats: scr_guns_calculateGunStats(char, gun)
    };
    
    array_push(char.guns, slot);
    
	if (equip) scr_guns_equipGun(char, array_length(char.guns) - 1);
	
}

function scr_guns_equipGun(char, index) {

    if (!instance_exists(char)) return false;

    var len = array_length(char.guns);

    if (index < 0 or index >= len) return false;

    char.gunIndex = index;

    var slot = char.guns[index];

    char.gun = slot.gun;
    char.gunStats = slot.stats;
	
    return true;

}

function scr_guns_replaceGun(char, index, gun) {

    if (!instance_exists(char)) return undefined;

    var oldSlot = char.guns[index];
    var oldGun = oldSlot.gun;

    var newSlot = {
        gun: gun,
        stats: scr_guns_calculateGunStats(char, gun)
    };

    char.guns[index] = newSlot;

    if (char.gunIndex == index) {
        scr_guns_equipGun(char, index);
    }

    return oldGun;

}

function scr_guns_calculateGunStats(char, gun) {

	if (!instance_exists(char)) return undefined;
	if (!is_struct(gun)) return undefined;

	var newStats = {};
	
	scr_data_structCopyInto(newStats, gun);
	
	newStats.damage.kin = scr_stats_calculateStat(newStats.damage.kin, char.stats.kinDamPerc) + char.finalStats.kinDam;
	newStats.damage.fire = scr_stats_calculateStat(newStats.damage.fire, char.stats.fireDamPerc) + char.finalStats.fireDam;
	newStats.damage.chem = scr_stats_calculateStat(newStats.damage.chem, char.stats.chemDamPerc) + char.finalStats.chemDam;
	newStats.damage.elec = scr_stats_calculateStat(newStats.damage.elec, char.stats.elecDamPerc) + char.finalStats.elecDam;
	newStats.damage.rad = scr_stats_calculateStat(newStats.damage.rad, char.stats.radDamPerc) + char.finalStats.radDam;
	
	var range = scr_stats_calculateDamageRange(newStats.damage.kin);
	newStats.damage.kinMin = range.minDam;
	newStats.damage.kinMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newStats.damage.fire);
	newStats.damage.fireMin = range.minDam;
	newStats.damage.fireMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newStats.damage.chem);
	newStats.damage.chemMin = range.minDam;
	newStats.damage.chemMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newStats.damage.elec);
	newStats.damage.elecMin = range.minDam;
	newStats.damage.elecMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newStats.damage.rad);
	newStats.damage.radMin = range.minDam;
	newStats.damage.radMax = range.maxDam;
	
	return newStats;
	
}
