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
		
		damage: 12,
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
	var proj = noone;
	
	if (gun.ammo > 0 and gun.fireTick <= 0) {
		
		proj = scr_projectiles_shoot(char);

		if (proj == noone) return noone;
		
		var profile = gun.shootSounds;
		var snd = scr_audio_randomSoundFromProfile(profile);
		if (snd != undefined) audio_play_sound_at(snd, char.x, char.y, 0, 200, 1600, 1, false, 0);
		
		gun.fireTick = 60 / gun.fireRate;
		
		gun.ammo --;
		
		if (gun.ammo < 1) {
			
			if (gun.temporary) {
			
				var len = array_length(char.guns);
				
				for (var i = 0; i < len; i ++) {
				
					var thisGun = guns[i];
					if (thisGun == gun) array_delete(char.guns, i, 1);
					char.gunIndex --;
					
				}
			
			} else {
			
				gun.reload = gun.reloadTime * 60;
			
			}
			
		}
		
	}
	
	return proj;

}

function scr_guns_reload(gun) {

	if (!is_struct(gun)) return false;
	if (gun.ammo == gun.clipSize) return false;

	gun.ammo = 0;
	gun.reload = gun.reloadTime * 60;
	
	return true;
	
}

function scr_guns_collectGun(char, gun) {
	
	if (!instance_exists(char)) exit;
	
	gun.ammo = gun.clipSize;
	
	array_push(char.guns, gun);
	
	var len = array_length(char.guns);
	
	char.gunIndex = len - 1;
	
}