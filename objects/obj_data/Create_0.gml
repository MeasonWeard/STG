global.data = self;

#macro HASH_CELL_SIZE 256
#macro MIN_FALLOFF 400
#macro MAX_FALLOFF 1200
#macro FALLOFF_FACTOR 1
#macro FALLOFF_FACTOR_EXPLOSION 0.8
#macro MIN_FALLOFF_BULLETHIT 100
#macro MAX_FALLOFF_BULLETHIT 1200
#macro MAX_FALLOFF_EXPLOSION 1600
#macro FALLOFF_FACTOR_BULLETHIT 1.2
#macro THORNS_IMMUNITY_TIME 0.5
#macro LOOT_BIAS 3
#macro ITEM_PULL_RANGE 480
#macro COLLECTION_RANGE 32
#macro ITEM_PULL_STRENGTH 16
#macro MAX_DATA_DROPS 12

//display
resolutions = [];
resolutionIndex = 0;
array_push(resolutions, [1920, 1080]);
array_push(resolutions, [1664, 936]);
array_push(resolutions, [1280, 720]);
array_push(resolutions, [1024, 576]);

//settings
global.settingsDirty = false;

defaultSettings = {

	windowed: false,
	res: [1280, 720],
	
	showReloadOnCursor: true,
	showMeleeOnCursor: true,
	showSkillsOnCursor: true,
	showAmmoOnCursor: true
	
}

enum layers {
	
	physical = 0,
	decorations = 800,
	ground = 900,
	groundDecorations = 800,
	projectiles = -400,
	lighting = -700,
	borders = -800,
	effects = -6000,
	ui = -9000,
	ui2 = -10000,
	cursor = -11000 
	
}

enum projectileTypes {  

	normal = 0,
	blast = 1
	
}

enum damageTypes {

	projectile = 0,
	melee = 1,
	ability = 2,
	dot = 3,
	environmental = 4
	
}

enum itemTypes {
	
	weapon = 0,
	gun = 2,
	melee = 3,
	gear = 4,
	device = 5,
	headgear = 6,
	tie = 7
	
}

enum classes {
	
	physics = 0,
	chemistry = 1,
	biology = 2,
	engineering = 3
	
}

rarities = {
	
	alpha: {
		num: 1,
		col: c_white,
		name: "Alpha"
	},
	
	beta: {
		num: 2,
		col: c_blue,
		name: "Beta"
	},
	
	gamma: {
		num: 3,
		col: #00FF00,
		name: "Gamma"
	},
	
	delta: {
		num: 4,
		col: #FF5200,
		name: "Delta"
	},
	
	sigma: {
		num: 5,
		col: #ED008C,
		name: "Sigma"
	},
	
	omega: {
		num: 6,
		col: #FF0009,
		name: "Omega"
	},
	
}

colours = {

	windowBackground: #324E7F,
	windowText: c_white
	
}

resourceOrder = ["data","metals","polymers","fissiles"];

resources = {

	def: {
		name: "not found",
		icon: spr_missing
	},

	//main

	data: {
		name: "Data",
		icon: spr_res_data
	},
	
	metals: {
		name: "Metals",
		icon: spr_res_metals
	},
	
	polymers: {
		name: "Polymers",
		icon: spr_res_polymers
	},
	
	fissiles: {
		name: "Fissile Materials",
		icon: spr_res_fissiles
	},
	
	//common

	bio: {
		name: "Bio Waste",
		icon: spr_res_bio
	},
	
	alienOrgan: {
		name: "Alien Organ",
		icon: spr_res_alienOrgan
	}
	
}

//stages
stages = {

	def: {
	
		room: undefined,
		name: "none",
		mapCol: c_blue
	
	},
	
	wasteHall1: {
		
		room: stage_wasteHall1,
		
	},
	
	wasteArena1: {
		
		room: stage_wasteArena1,
		mapCol: c_orange
		
	},
	
	wasteArenaLava1: {
		
		room: stage_wasteArenaLava1,
		mapCol: c_orange
		
	},
	
	wasteArenaAcid1: {
		
		room: stage_wasteArenaAcid1,
		mapCol: c_orange
		
	},

	engHall1: {
		
		room: stage_engHall1
		
	},
	
	engHall2: {
		
		room: stage_engHall2
		
	},
	
	engComputerRoom: {
		
		room: stage_engComputerRoom
		
	},
	
	engBoss1: {
		
		room: stage_engBoss1
		
	}
	
}

soundProfiles = {

	//bullet hits
	bulletHitMetal: [snd_bulletHitMetal1, snd_bulletHitMetal2, snd_bulletHitMetal3, snd_bulletHitMetal4],
	bulletHitMetalHigh: [snd_bulletHitMetalHigh1, snd_bulletHitMetalHigh2, snd_bulletHitMetalHigh3, snd_bulletHitMetalHigh4],
	bulletHitFlesh: [snd_bulletHitFlesh],
	bulletHitRock: [snd_bulletHitRock1, snd_bulletHitRock2, snd_bulletHitRock3],
	bulletHitShield: [snd_shieldDamage1, snd_shieldDamage2, snd_shieldDamage3],
	
	//weaponshots
	blaster: [snd_blaster1, snd_blaster2, snd_blaster3],
	smg: [snd_smg1, snd_smg2, snd_smg3],
	shotgun: [snd_shotgun1, snd_shotgun2, snd_shotgun3],
	pistol: [snd_pistol1, snd_pistol2, snd_pistol3],
	pulse: [snd_pulse1, snd_pulse2, snd_pulse3],
	alienBlast: [snd_alienBlast1, snd_alienBlast2, snd_alienBlast3],
	spiderShoot: [snd_spiderShoot1, snd_spiderShoot2, snd_spiderShoot3],
	alienShoot: [snd_alienShoot1, snd_alienShoot2, snd_alienShoot3],
	
	//melee
	cleaverSwing: [snd_cleaverSwing1, snd_cleaverSwing2, snd_cleaverSwing3],
	cleaverHit: [snd_cleaverHit1, snd_cleaverHit2, snd_cleaverHit3],
	hammerHit: [snd_hammerHit1, snd_hammerHit2, snd_hammerHit3],
	prod: [snd_prod1, snd_prod2, snd_prod3],
	swish: [snd_swish1, snd_swish2, snd_swish3, snd_swish4],
	
	//characters
	jeffDeath: [snd_jeffDeath1, snd_jeffDeath2, snd_jeffDeath3],
	
	//sfx
	fleshExplod: [snd_fleshExplode1, snd_fleshExplode2, snd_fleshExplode3],
	burn: [snd_burn1, snd_burn2, snd_burn3],
	microMissile: [snd_microMissile1, snd_microMissile2, snd_microMissile3],
	collect: [snd_collect1, snd_collect2, snd_collect3]
	
}

enemyGroups = {

	mutantsSmall: [[obj_bertha, 100]],
	mutantsBig: [[obj_bertha, 100],[obj_celia,25]],
	
	aliensSmall: [[obj_alien, 100]],
	aliendsBig: [[obj_alien, 100]],
	
	spidersSmall: [[obj_spiderDrone, 100],[obj_spiderDroneKamikaze, 20]],
	spidersBig: [[obj_spiderDrone, 100],[obj_spiderDroneKamikaze, 20]]
	
}

skillConstructors = {
	test: skill_test,
    rubberBoots: skill_rubberBoots,
    chainLightning: skill_chainLightning,
    antimatterBlast: skill_antimatterBlast
};


//LOAD GAME
global.saveFile = scr_file_getLatestSave();
global.gameData = scr_file_loadGame(global.saveFile);

//create new save
if (global.gameData == undefined) {

	global.gameData = scr_file_createBlankSave();
	scr_file_saveGame("save0", global.gameData);
	
}