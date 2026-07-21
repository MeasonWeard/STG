function gun_blaster(level, rarity) : gunInst(level, rarity) constructor {

	name = "Blaster";
	recoil = 1.2;
	clipSize = 24;
	reloadTime = 1.8;
	spr = spr_blaster;
	
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
	spr = spr_pistol;
	
	auto = false;
	range = 1000;
	damage.kin = 16;
	fireRate = 6.2;
	clipSize = 12;
	reloadTime = 1.4;
	spd = 22;
	minAimOff = 2.2;
	maxAimOff = 7;
	recoil = 1.8;
	stability = 0.08;

	shootSounds = global.data.soundProfiles.pistol;

}

function gun_smg(level, rarity): gunInst(level, rarity) constructor {

	name = "SMG";
	spr = spr_smg;
	
	auto = true;
	range = 1000;
	clipSize = 32;
	fireRate = 12;
	reloadTime = 1.6;
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
	spr = spr_pulseRifle;
	
	auto = true;
	range = 1400;
	damage.kin = 32;
	clipSize = 8;
	fireRate = 2.8;
	reloadTime = 2.2;
	spd = 26;
	minAimOff = 1.6;
	maxAimOff = 8;
	recoil = 4;
	stability = 0.14;
	shootSounds = global.data.soundProfiles.pulse;
	
	bonusStats = {
		oa: 15	
	}

}

function gun_shotgun(level, rarity) : gunInst(level, rarity) constructor {

	name = "Shotgun";
	spr = spr_shotgun;
	
	auto = false;
	fireRate = 1.2;
	damage.kin = 10;
	clipSize = 4;
	reloadTime = 2.6;
	projectileType = projectileTypes.blast;
	blastProjectiles = 8;
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
	spr = spr_autoShotgun;
	
	auto = true;
	fireRate = 1.6;
	damage.kin = 9;
	clipSize = 8;
	reloadTime = 2.5;
	projectileType = projectileTypes.blast;
	blastProjectiles = 6;
	blastSpread = 7;
	shootSounds = global.data.soundProfiles.shotgun;
	range = 800;
	//projSprite = spr_bullet3;
	minAimOff = 3;
	maxAimOff = 9;
	recoil = 3;
	stability = 0.05;
	
}

//ENEMY AND PET GUNS

function gun_alienOrb(level, rarity) : gunInst(level, rarity) constructor {

	name = "Alien Orb Launcher #1"
	
	projSprite = spr_bullet_alienSpit;
	auto = false;
	clipSize = 2;
	fireRate = 0.8;
	reloadTime = 1.8;
	spd = 16;
	minAimOff = 2.2;
	maxAimOff = 8;
	recoil = 1.8;
	stability = 0.08;
	rot = 3;
	
	damage.kin = 2;
	damage.chem = 3;
	
	shootSounds = global.data.soundProfiles.alienShoot;
	
}

function gun_alienOrb2(level, rarity) : gunInst(level, rarity) constructor {

	name = "Alien Orb Launcher #2";
	
	projSprite = spr_bullet3;
	projectileType = projectileTypes.blast;
	blastProjectiles = 6;
	auto = true;
	clipSize = 4;
	fireRate = 1;
	reloadTime = 2.8;
	spd = 12;
	minAimOff = 2.4;
	maxAimOff = 14;
	recoil = 2.4;
	stability = 0.06;
	
	damage.kin = 3;
	damage.chem = 5;
	
	shootSounds = global.data.soundProfiles.alienBlast;
	
}

function gun_spiderGun(level, rarity) : gunInst(level, rarity) constructor {

	name = "Spider Gun #1"
	
	projSprite = spr_spiderBullet;
	auto = true;
	fireRate = 4;
	clipSize = 2;
	reloadTime = 1.8;
	spd = 16;
	minAimOff = 2.2;
	maxAimOff = 8;
	recoil = 1.8;
	stability = 0.08;
	rot = 12;
	
	shootSounds = global.data.soundProfiles.spiderShoot;
	
	damage.kin = 2;
	damage.rad = 2;
	
}

function gun_fungalGun(level, rarity) : gunInst(level, rarity) constructor {

	name = "Fungal Gun";
	
	projSprite = spr_bullet3;
	projectileType = projectileTypes.blast;
	blastProjectiles = 12;
	blastSpread = 10;
	auto = true;
	clipSize = 1;
	fireRate = 0.8;
	reloadTime = 0.8;
	spd = 10;
	minAimOff = 2.4;
	maxAimOff = 14;
	recoil = 2.4;
	stability = 0.06;
	
	damage.kin = 3;
	damage.chem = 8;
	
	shootSounds = global.data.soundProfiles.alienBlast;
	
}