function gun_blaster(level, rarity) : gunInst(level, rarity) constructor {

	name = "Blaster";
	recoil = 1.2;
	clipSize = 24;
	reloadTime = 1.8;
	
	//shootSounds = global.data.soundProfiles.blaster;
	//reloadSound = undefined;
	//projSprite = spr_bullet1;
	//spr = spr_gun;
	//description = undefined;
	
	////attack
	//auto = true;
	//projectileType = projectileTypes.normal;
	//fireRate = 8;
	//blastProjectiles = 5;
	//blastSpread = 10;
	//spd = 22;
	//range = 1200;
	//collisionFunc = undefined;

	////aim
	//minAimOff = 2;
	//maxAimOff = 6;
	//recoil = 0.8;
	//stability = 0.1;
		
	////ammo
	//clipSize = 24;
	//ammo = 24;
	//reloadTime = 2.2;

	//damage.kin = 12
	
}

function gun_pistol(level, rarity): gunInst(level, rarity) constructor {

	name = "Pistol";
	
	auto = false;
	range = 1000;
	clipSize = 12;
	fireRate = 6.2;
	reloadTime = 1.6;
	spd = 22;
	minAimOff = 2.2;
	maxAimOff = 7;
	recoil = 1.8;
	stability = 0.08;
	damage.kin = 22;
	shootSounds = global.data.soundProfiles.pistol;

}

function gun_smg(level, rarity): gunInst(level, rarity) constructor {

	name = "SMG";
	
	auto = true;
	range = 1000;
	clipSize = 32;
	fireRate = 12;
	reloadTime = 2;
	spd = 22;
	minAimOff = 2.4;
	maxAimOff = 8;
	recoil = 1.4;
	stability = 0.12;
	damage.kin = 8;
	shootSounds = global.data.soundProfiles.smg;

}

function gun_pulseRifle(level, rarity): gunInst(level, rarity) constructor {

	name = "Pulse Rifle";
	
	auto = true;
	range = 1400;
	clipSize = 8;
	fireRate = 2.8;
	reloadTime = 3;
	spd = 26;
	minAimOff = 1.6;
	maxAimOff = 10;
	recoil = 4;
	stability = 0.12;
	damage.kin = 26;
	shootSounds = global.data.soundProfiles.pulse;
	
	bonusStats = {
		oa: 15	
	}

}

function gun_shotgun(level, rarity) : gunInst(level, rarity) constructor {

	name = "Shotgun";
	
	auto = false;
	fireRate = 1.2;
	damage.kin = 10;
	clipSize = 4;
	reloadTime = 2.6;
	projectileType = projectileTypes.blast;
	blastProjectiles = 10;
	blastSpread = 8;
	shootSounds = global.data.soundProfiles.shotgun;
	range = 800;
	//projSprite = spr_bullet3;
	minAimOff = 3;
	maxAimOff = 9;
	recoil = 3;
	stability = 0.05;
	
}

function gun_autoShotgun(level, rarity) : gunInst(level, rarity) constructor {

	name = "Auto Shotgun";
	
	auto = true;
	fireRate = 1.6;
	damage.kin = 8;
	clipSize = 8;
	reloadTime = 2.6;
	projectileType = projectileTypes.blast;
	blastProjectiles = 8;
	blastSpread = 7;
	shootSounds = global.data.soundProfiles.shotgun;
	range = 800;
	//projSprite = spr_bullet3;
	minAimOff = 3;
	maxAimOff = 9;
	recoil = 3;
	stability = 0.05;
	
}

function gun_alienOrb(level, rarity) : gunInst(level, rarity) constructor {

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

function gun_alienOrb2(level, rarity) : gunInst(level, rarity) constructor {

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