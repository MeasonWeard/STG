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
#macro LOOT_BIAS_MILD 2
#macro LOOT_BIAS_HEAVY 4
#macro ITEM_PULL_RANGE 480
#macro COLLECTION_RANGE 32
#macro ENEMY_CHASE_RANGE 2000
#macro ALERT_ENEMIES_IDEAL 24
#macro ITEM_PULL_STRENGTH 16
#macro MAX_DATA_DROPS 12
#macro FRAME_TIME 1 / 60

//display
resolutions = [];
resolutionIndex = 0;
array_push(resolutions, [800, 450]);
array_push(resolutions, [1024, 576]);
array_push(resolutions, [1280, 720]);
array_push(resolutions, [1366, 768]);
array_push(resolutions, [1600, 900]);
array_push(resolutions, [1920, 1080]);

defaultSettings = {

	fullscreen: true,
	resIndex: 0,
	
	showReloadOnCursor: true,
	showSkillsOnCursor: false,
	alwaysShowWeaponName: false,
	showAmmo: 1,
	
	musicVolume: 1,
	sfxVolume: 1
	
}

enum layers {
	
	physical = 0,
	decorations = 800,
	ground = 900,
	groundDecorations = 800,
	hazards = 700,
	projectiles = -400,
	lighting = -700,
	borders = -800,
	ceiling = -5000,
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
	tie = 7,
	coat = 8
	
}

enum stageTypes {

	hall = 0,
	arena = 1,
	boss = 2,
	special = 3
	
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
	
	unique: {
		num: -1,
		col: c_yellow,
		name: "Unique"
	}
	
}

colours = {

	highlight: c_aqua,
	text: c_white,
	textHighlighted: c_aqua,
	textClicked: c_navy,
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
	},
	
	chip: {
		name: "Microchip",
		icon: spr_res_chip
	}
	
}

//stages
stages = {

	def: {
	
		room: undefined,
		name: "none",
		mapCol: c_blue,
		type: stageTypes.hall
	
	},
	
	//waste disposal
	
	wasteHall1: {
		
		room: stage_wasteHall1,
		
	},
	
	wasteArena1: {
		
		room: stage_wasteArena1,
		mapCol: c_orange,
		type: stageTypes.arena
		
	},
	
	wasteArena2: {
		
		room: stage_wasteArena2,
		mapCol: c_orange,
		type: stageTypes.arena
		
	},
	
	wasteArenaLava1: {
		
		room: stage_wasteArenaLava1,
		mapCol: c_orange,
		type: stageTypes.arena
		
	},
	
	wasteArenaAcid1: {
		
		room: stage_wasteArenaAcid1,
		mapCol: c_orange,
		type: stageTypes.arena
		
	},
	
	wasteArenaAcid2: {
		
		room: stage_wasteArenaAcid2,
		mapCol: c_orange,
		type: stageTypes.arena
		
	},
	
	wasteIncinerator1: {
	
		room: stage_wasteIncinerator1,
		mapCol: c_red,
		type: stageTypes.special
	
	},
	
	wasteIncinerator2: {
	
		room: stage_wasteIncinerator2,
		mapCol: c_red,
		type: stageTypes.special
	
	},
	
	wasteAcidRiver: {
	
		room: stage_wasteAcidRiver,
		mapCol: c_green,
		type: stageTypes.special
	
	},
	
	wasteBoss1: {
		
		room: stage_wasteBoss1,
		type: stageTypes.boss,
		mapCol: c_lime,
		
	},
	
	//commercial
	
	commPlaza1: {
	
		room: stage_commPlaza1,
		type: stageTypes.arena,
		mapCol: c_orange
	
	},
	
	commPlaza2: {
	
		room: stage_commPlaza2,
		type: stageTypes.arena,
		mapCol: c_orange
	
	},
	
	commPlaza3: {
	
		room: stage_commPlaza3,
		type: stageTypes.arena,
		mapCol: c_orange
	
	},
	
	cinema1: {
	
		room: stage_commCinema1,
		type: stageTypes.special,
		mapCol: c_red
	
	},
	
	cinema2: {
	
		room: stage_commCinema2,
		type: stageTypes.special,
		mapCol: c_red
	
	},
	
	market1: {
	
		room: stage_commMarket1,
		type: stageTypes.special,
		mapCol: c_green
	
	},
	
	market2: {
	
		room: stage_commMarket2,
		type: stageTypes.special,
		mapCol: c_green
	
	},
	
	clothing1: {
	
		room: stage_commClothing1,
		type: stageTypes.special,
		mapCol: c_purple
	
	},
	
	clothing2: {
	
		room: stage_commClothing2,
		type: stageTypes.special,
		mapCol: c_purple
	
	},
	
	//hydroponics
	hydroLabs1: {
	
		room: stage_hydroLabs1,
		type: stageTypes.arena,
		mapCol: c_orange
	
	},

	//engineering

	engHall1: {
		
		room: stage_engHall1
		
	},
	
	engHall2: {
		
		room: stage_engHall2
		
	},
	
	engComputerRoom: {
		
		room: stage_engComputerRoom,
		type: stageTypes.arena
		
	},
	
	engBoss1: {
		
		room: stage_engBoss1,
		type: stageTypes.boss
		
	}
	
}

elementCols = {

	kin: c_yellow,
	fire: #FF2D00,
	chem: c_lime,
	elec: c_aqua,
	rad: c_purple
	
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
	fungusBlast: [snd_fungusBlast1, snd_fungusBlast2, snd_fungusBlast3],
	sprayGun: [snd_sprayGun1, snd_sprayGun2, snd_sprayGun3],
	sniper: [snd_sniper1, snd_sniper2, snd_sniper3],
	
	//melee
	cleaverSwing: [snd_cleaverSwing1, snd_cleaverSwing2, snd_cleaverSwing3],
	cleaverHit: [snd_cleaverHit1, snd_cleaverHit2, snd_cleaverHit3],
	hammerHit: [snd_hammerHit1, snd_hammerHit2, snd_hammerHit3],
	batonHit: [snd_baton1, snd_baton2, snd_baton3],
	prod: [snd_prod1, snd_prod2, snd_prod3],
	swish: [snd_swish1, snd_swish2, snd_swish3, snd_swish4],
	
	//characters
	plantDeath: [snd_plantDeath1, snd_plantDeath2, snd_plantDeath3],
	
	//sfx
	fleshExplod: [snd_fleshExplode1, snd_fleshExplode2, snd_fleshExplode3],
	burn: [snd_burn1, snd_burn2, snd_burn3],
	microMissile: [snd_microMissile1, snd_microMissile2, snd_microMissile3],
	collect: [snd_collect1, snd_collect2, snd_collect3],
	bottleBreak: [snd_bottleBreak1, snd_bottleBreak2, snd_bottleBreak3, snd_bottleBreak4],
	emp: [snd_emp1, snd_emp2, snd_emp3]
	
}

skillConstructors = {
	
	antimatterBlast: skill_antimatterBlast, //phys
	teleport: skill_teleport, // phys
	singularity: skill_singularity, //phys
	particleShower: skill_particleShower, //phys
	
	joltzmanShield: skill_joltzmanShield, //phys,
	radioactiveBullets: skill_radioactiveBullets, //phys
	leadCoat: skill_leadCoat, //phys,
	vacuumEnergy: skill_vacuumEnergy, //phys
	predictiveModelling: skill_predictiveModelling, //phys
	
	acidFlasks: skill_acidFlasks, //chem	
	flamethrower: skill_flamethrower, //chem
	thermiteCharge: skill_thermiteCharge, //chem
	napalm: skill_napalm, //chem
	
	PPE: skill_PPE, //chem
	medicalSynthesis: skill_medicalSynthesis, //chem
	acidicBullets: skill_acidicBullets, //chem
	gas: skill_gas, //chem
	flashpoint: skill_flashpoint, //chem
	
	fungalTurret: skill_fungalTurret, //bio
	blob: skill_blob, //bio
	medicalExosomes: skill_medicalExosomes, // bio,
	symbiont: skill_symbiont, //bio
	
	muscleGrowth: skill_muscleGrowth, //bio
	homeostasis: skill_homeostasis, //bio
	radiotrophy: skill_radiotrophy, //bio
	chitin: skill_chitin, //bio
	adrenalGlands: skill_adrenalGlands, //bio
	
	chainLightning: skill_chainLightning, // eng
	turret: skill_turret, //eng
	emp: skill_EMP, //eng
	mech: skill_mech, //end
	
	rubberBoots: skill_rubberBoots, //eng
	guardianArray: skill_guardianArray, //eng
	shieldBattery: skill_shieldBattery, //eng
	kevlar: skill_kevlar, //eng
	gunsmith: skill_gunsmith, //eng
	targetingMonocle: skill_targetingMonocle //eng
	
};


//LOAD GAME
global.saveFile = scr_file_getLatestSave();
global.gameData = scr_file_loadGame(global.saveFile);

//create new save
if (global.gameData == undefined) {

	global.gameData = scr_file_createBlankSave();
	global.freshSave = true;
	
}