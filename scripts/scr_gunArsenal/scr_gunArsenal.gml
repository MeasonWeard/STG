function scr_gunArsenal_blaster(){

	var gun = scr_guns_createGun("Blaster");
	return gun;

	//shootSounds: global.data.soundProfiles.blaster,
	//reloadSound: undefined,
	//projSprite: spr_bullet1,
		
	////attack
	//auto: true,
	//fireRate: 12,
		
	//damage: 12,
	//spd: 22,
	//range: 1600,
	//collisionFunc: undefined,
		
	////aim
	//minAimOff: 2,
	//maxAimOff: 6,
	//recoil: 0.8,
	//stability: 0.1,
		
	////ammo
	//clipSize: 45,
	//ammo: 45,
	//reloadTime: 2.2,
	
}

function scr_gunArsenal_pistol() {

	var gun = scr_guns_createGun("Pistol");
	
	gun.auto = false;
	gun.clipSize = 12;
	gun.fireRate = 8;
	gun.reloadTime = 1.6;
	gun.spd = 22;
	gun.minAimOff = 2.2;
	gun.maxAimOff = 8;
	gun.recoil = 1.8;
	gun.stability = 0.08;
	gun.damage.kin = 16;
	gun.shootSounds = global.data.soundProfiles.pistol;
	
	return gun;
	
}

function scr_gunArsenal_devastator(){

	var gun = scr_guns_createGun("Devastator");
	
	gun.collisionFunc = scr_effects_microMissile;
	gun.clipSize = 24;
	gun.fireRate = 16;
	gun.damage.kin = 4;
	gun.recoil = 1.2;
	gun.minAimOff = 3;
	gun.maxAimOff = 12;
	gun.spd = 30;
	gun.reloadTime = 3.8;
	gun.projSprite = spr_microMissile;
	
	return gun;

}

function scr_gunArsenal_shotty() {

	var gun = scr_guns_createGun("Shotty");
	
	gun.auto = true;
	gun.fireRate = 1.4;
	gun.damage.kin = 9;
	gun.clipSize = 5;
	gun.reloadTime = 2.6;
	gun.projectileType = projectileTypes.blast;
	gun.blastProjectiles = 7;
	gun.blastSpread = 5;
	gun.shootSounds = global.data.soundProfiles.shotgun;
	gun.range = 1200;
	gun.projSprite = spr_bullet3;
	gun.minAimOff = 3;
	gun.maxAimOff = 9;
	gun.recoil = 3;
	gun.stability = 0.05;
	
	return gun;
	
}

function scr_gunArsenal_alienOrb() {

	var gun = scr_guns_createGun("Alien Orb Launcher");
	
	gun.projSprite = spr_bullet2;
	gun.auto = false;
	gun.clipSize = 2;
	gun.fireRate = 0.6;
	gun.reloadTime = 1.8;
	gun.spd = 16;
	gun.minAimOff = 2.2;
	gun.maxAimOff = 8;
	gun.recoil = 1.8;
	gun.stability = 0.08;
	
	gun.damage.kin = 4;
	
	gun.shootSounds = global.data.soundProfiles.alienShoot;
	
	return gun;
	
}

function scr_gunArsenal_alienOrb2() {

	var gun = scr_guns_createGun("Alien Orb Launcher #2");
	
	gun.projSprite = spr_bullet3;
	gun.auto = true;
	gun.clipSize = 16;
	gun.fireRate = 6;
	gun.reloadTime = 2.8;
	gun.spd = 12;
	gun.minAimOff = 2.4;
	gun.maxAimOff = 14;
	gun.recoil = 2.4;
	gun.stability = 0.06;
	
	gun.damage.kin = 4;
	gun.damage.chem = 4;
	
	gun.shootSounds = global.data.soundProfiles.alienBlast;
	
	return gun;
	
}