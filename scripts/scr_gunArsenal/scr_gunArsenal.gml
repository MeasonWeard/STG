function gun_blaster(level, rarity) : gunInst(level, rarity) constructor {

	name = "Blaster";
	recoil = 1.2;
	clipSize = 24;
	reloadTime = 1.8;
	spr = spr_blaster;
	
	//shootSounds = global.data.soundProfiles.blaster;
	//reloadSound = undefined;
	//projSprite = spr_bulletNormal;
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
	projSprite = spr_bulletLarge;
	
	damage.kin = 16;
	baseDamage = 16;
	
	auto = false;
	range = 1000;
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
	
	damage.kin = 8;
	baseDamage = 8;
	
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
	shootSounds = global.data.soundProfiles.smg;

}

function gun_pulseRifle(level, rarity): gunInst(level, rarity) constructor {

	name = "Pulse Rifle";
	spr = spr_pulseRifle;
	projSprite = spr_bulletLarge;
	
	damage.kin = 36;
	baseDamage = 36;
	
	auto = true;
	range = 1400;
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
	projSprite = spr_bulletSmall;
	
	damage.kin = 10;
	baseDamage = 10;
	
	auto = false;
	fireRate = 1.2;
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

	name = "Auto-Shotgun";
	spr = spr_autoShotgun;
	projSprite = spr_bulletSmall;
	
	damage.kin = 9;
	baseDamage = 9;
	
	auto = true;
	fireRate = 1.6;
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

function gun_alienSpit(level, rarity) : gunInst(level, rarity) constructor {

	name = "Alien Spit"
	
	projSprite = spr_bullet_alienSpit;
	projDestroySprite = spr_bullet_alienSpitExplode;
	lockProjSprite = true;
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
	range = 800;
	
	damage.kin = 2;
	damage.chem = 3;
	
	shootSounds = global.data.soundProfiles.alienShoot;
	
}

function gun_bigAlienSpit(level, rarity) : gunInst(level, rarity) constructor {

	name = "Alien Spit BIG"
	
	projSprite = spr_bullet_alienSpit2;
	projDestroySprite = spr_bullet_alienSpitExplode;
	lockProjSprite = true;
	auto = false;
	clipSize = 6;
	fireRate = 20;
	reloadTime = 1.8;
	spd = 18;
	minAimOff = 2.2;
	maxAimOff = 10;
	recoil = 1.8;
	stability = 0.08;
	rot = 3;
	range = 860;
	
	damage.kin = 3;
	damage.chem = 4;
	
	shootSounds = global.data.soundProfiles.alienShoot;
	
}

function gun_bigRadAlienSpit(level, rarity) : gunInst(level, rarity) constructor {

	name = "Alien Spit RAD BIG"
	
	projSprite = spr_bullet_alienSpit3;
	projDestroySprite = spr_bullet_alienSpitExplode;
	lockProjSprite = true;
	auto = false;
	clipSize = 6;
	fireRate = 20;
	reloadTime = 1.8;
	spd = 18;
	minAimOff = 2.2;
	maxAimOff = 10;
	recoil = 1.8;
	stability = 0.08;
	rot = 3;
	range = 860;
	
	damage.chem = 3;
	damage.rad = 4;
	
	shootSounds = global.data.soundProfiles.fungusBlast;
	
}

function gun_celiaGun(level, rarity) : gunInst(level, rarity) constructor {

	name = "Celia?";
	
	projSprite = spr_bullet3;
	lockProjSprite = true;
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
	projDestroySprite = spr_bulletExplosion2;
	lockProjSprite = true;
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

function gun_bigSpiderGun(level, rarity) : gunInst(level, rarity) constructor {

	name = "Big Spider Gun"
	
	projSprite = spr_bulletNormal;
	projDestroySprite = spr_bulletExplosion2;
	auto = true;
	fireRate = 8;
	clipSize = 12;
	reloadTime = 1.6;
	spd = 16;
	minAimOff = 2.2;
	maxAimOff = 8;
	recoil = 1.8;
	stability = 0.08;
	
	shootSounds = [snd_electricBullet];
	
	damage.kin = 6;
	
}

function gun_bigMutantGun(level, rarity) : gunInst(level, rarity) constructor {

	name = "Four Guns"
	
	projSprite = spr_bulletNormal;
	projDestroySprite = spr_bulletExplosion2;
	auto = true;
	fireRate = 10;
	clipSize = 8;
	reloadTime = 1.5;
	spd = 16;
	minAimOff = 2.4;
	maxAimOff = 10;
	recoil = 2;
	stability = 0.08;
	
	shootSounds = [snd_electricBullet];
	
	damage.kin = 5;
	
}

function gun_bigMutantPulseGun(level, rarity) : gun_pulseRifle(level, rarity) constructor {

	name = "Four Guns"
	
	clipSize = 4;
	damage.kin = 16;
	
}

function gun_bigSpiderFireGun(level, rarity) : gunInst(level, rarity) constructor {

	name = "Big Spider Flame Gun"
	
	projectileType = projectileTypes.blast;
	blastProjectiles = 6;
	blastSpread = 14;
	
	projSprite = spr_bulletLarge;
	projDestroySprite = spr_bulletExplosion2;
	auto = true;
	fireRate = 4;
	clipSize = 2;
	reloadTime = 1.8;
	spd = 10;
	minAimOff = 2.2;
	maxAimOff = 8;
	recoil = 1.8;
	stability = 0.08;
	rot = 12;

	range = 950;
	shootSounds = global.data.soundProfiles.sprayGun;
	
	damage.kin = 2;
	damage.fire = 4;
	
}

function gun_bigSpiderElectricGun(level, rarity) : gunInst(level, rarity) constructor {

	name = "Big Spider Electric Gun"
	
	projSprite = spr_bulletNormal;
	projDestroySprite = spr_bulletExplosion2;
	auto = true;
	fireRate = 9;
	clipSize = 12;
	reloadTime = 1.6;
	spd = 16;
	minAimOff = 2.2;
	maxAimOff = 8;
	recoil = 1.8;
	stability = 0.08;
	
	shootSounds = [snd_electricBullet];

	damage.kin = 3;
	damage.elec = 5;
	
}

function gun_fungalGun(level, rarity) : gunInst(level, rarity) constructor {

	name = "Fungal Gun";
	
	projSprite = spr_bullet3;
	projDestroySprite = spr_bullet3Fade;
	lockProjSprite = true;
	projectileType = projectileTypes.blast;
	blastProjectiles = 12;
	blastSpread = 12;
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
	damage.chem = 6;
	
	shootSounds = global.data.soundProfiles.fungusBlast;
	
}

function gun_turretGun(level, rarity) : gunInst(level, rarity) constructor {

	name = "Turret Gun";
	spr = spr_smg;
	
	auto = true;
	range = 1000;
	clipSize = 18;
	fireRate = 10;
	reloadTime = 1.4;
	spd = 22;
	minAimOff = 2.4;
	maxAimOff = 8;
	recoil = 1.4;
	stability = 0.12;
	damage.kin = 8;
	shootSounds = global.data.soundProfiles.smg;
	
}

function gun_blobGun(level, rarity) : gunInst(level, rarity) constructor {

	name = "Blob gun"
	
	projSprite = spr_bullet_blobSpit;
	lockProjSprite = true;
	range = 216;
	auto = false;
	clipSize = 1;
	fireRate = 1.2;
	reloadTime = 1.2;
	spd = 16;
	minAimOff = 2.2;
	maxAimOff = 8;
	recoil = 1.8;
	stability = 0.08;
	rot = 3;
	
	damage.kin = 5;
	damage.chem = 5;
	
	shootSounds = global.data.soundProfiles.alienShoot;
	
}

function gun_plantGun(level, rarity) : gunInst(level, rarity) constructor {

	name = "Pollen Gun"
	
	projSprite = spr_bullet_plantSpit;
	projDestroySprite = spr_bullet_plantSpitExplode;
	lockProjSprite = true;
	auto = false;
	clipSize = 2;
	fireRate = 0.8;
	reloadTime = 1.8;
	spd = 14;
	minAimOff = 2.2;
	maxAimOff = 8;
	recoil = 1.8;
	stability = 0.08;
	rot = 3;
	range = 900;
	
	damage.kin = 3;
	damage.chem = 2;
	
	shootSounds = global.data.soundProfiles.alienShoot;
	
}

function gun_treeGun(level, rarity) : gunInst(level, rarity) constructor {

	name = "Pollen Gun 2"
	
	projSprite = spr_bullet_plantSpit;
	projDestroySprite = spr_bullet_plantSpitExplode;
	lockProjSprite = true;
	auto = false;
	clipSize = 6;
	fireRate = 12;
	reloadTime = 2;
	spd = 14;
	minAimOff = 2.4;
	maxAimOff = 12;
	recoil = 2.6;
	stability = 0.08;
	rot = 3;
	range = 900;
	
	damage.kin = 3;
	damage.chem = 4;
	
	shootSounds = global.data.soundProfiles.alienShoot;
	
}

function gun_mechPulseRifle(level, rarity): gunInst(level, rarity) constructor {

	name = "Pulse Rifle";
	spr = spr_pulseRifle;
	
	auto = true;
	range = 1400;
	damage.kin = 22;
	clipSize = 12;
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