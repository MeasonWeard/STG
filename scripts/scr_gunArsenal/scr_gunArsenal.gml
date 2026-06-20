function gun_blaster() : weapon_gun() constructor {

	name = "Blaster";
	recoil = 1.2;
	clipSize = 24;
	reloadTime = 1.8;
	
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

function gun_pistol(): weapon_gun() constructor {

	name = "Pistol";
	
	auto = false;
	clipSize = 12;
	fireRate = 8;
	reloadTime = 1.6;
	spd = 22;
	minAimOff = 2.2;
	maxAimOff = 8;
	recoil = 1.8;
	stability = 0.08;
	damage.kin = 16;
	shootSounds = global.data.soundProfiles.pistol;

}

function gun_devastator() : weapon_gun() constructor{

	name = "Devastator";
	
	collisionFunc = scr_effects_microMissile;
	clipSize = 24;
	fireRate = 16;
	damage.kin = 4;
	recoil = 1.2;
	minAimOff = 3;
	maxAimOff = 12;
	spd = 30;
	reloadTime = 3.8;
	projSprite = spr_microMissile;

}

function gun_shotgun() : weapon_gun() constructor {

	name = "Shotgun";
	
	auto = true;
	fireRate = 1.4;
	damage.kin = 9;
	clipSize = 5;
	reloadTime = 2.6;
	projectileType = projectileTypes.blast;
	blastProjectiles = 7;
	blastSpread = 5;
	shootSounds = global.data.soundProfiles.shotgun;
	range = 1200;
	projSprite = spr_bullet3;
	minAimOff = 3;
	maxAimOff = 9;
	recoil = 3;
	stability = 0.05;
	
}

function gun_alienOrb() : weapon_gun() constructor {

	name = "Alien Orb Launcher #1"
	
	projSprite = spr_bullet2;
	auto = false;
	clipSize = 2;
	fireRate = 0.6;
	reloadTime = 1.8;
	spd = 16;
	minAimOff = 2.2;
	maxAimOff = 8;
	recoil = 1.8;
	stability = 0.08;
	
	damage.kin = 4;
	
	shootSounds = global.data.soundProfiles.alienShoot;
	
}

function gun_alienOrb2() : weapon_gun() constructor {

	name = "Alien Orb Launcher #2";
	
	projSprite = spr_bullet3;
	auto = true;
	clipSize = 16;
	fireRate = 6;
	reloadTime = 2.8;
	spd = 12;
	minAimOff = 2.4;
	maxAimOff = 14;
	recoil = 2.4;
	stability = 0.06;
	
	damage.kin = 4;
	damage.chem = 4;
	
	shootSounds = global.data.soundProfiles.alienBlast;
	
}