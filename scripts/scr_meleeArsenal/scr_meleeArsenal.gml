function melee_cleaver(level, rarity) : meleeInst(level, rarity) constructor {

	damage.kin = 25;
	baseDamage = 25;
	
	attackRate = 2.4;
	rechargeTime = 1.6;
	//appearance
	//name = "Cleaver";
	//swingSounds = global.data.soundProfiles.cleaverSwing;
	//hitSounds = global.data.soundProfiles.cleaverHit;
	//attackSprites = [spr_slashUp, spr_slashDown];
	//spr = spr_melee;
	//description = undefined;
		
	////combat
	//attackRate = 2.8;
	//maxCharges = 6;
	//rechargeTime = 1.75;
		
	//damage.kin = 35;
		
	//killThreshold = 10;

}

function melee_hammer(level, rarity) : meleeInst(level, rarity) constructor {
	
	name = "Hammer";
	
	damage.kin = 50;
	baseDamage = 50;
	
	spr = spr_hammer;
	attackSprites = [spr_slam];
	swingSounds = global.data.soundProfiles.swish;
	hitSounds = global.data.soundProfiles.hammerHit;
	
	range = 64;
	hitDelay = 12;
	stopOnHit = true;
	
	attackRate = 1.2;
	maxCharges = 3;
	rechargeTime = 2.1;
	killThreshold = 20;
	damageInRadius = true;
	

	
}

function melee_prod(level, rarity) : meleeInst(level, rarity) constructor {
	
	name = "Prod";
	
	damage.kin = 0;
	damage.elec = 15;
	baseDamage = 15;
	damageInLine = true;
	
	spr = spr_prod;
	attackSprites = [spr_prodAttack];
	swingSounds = global.data.soundProfiles.prod;
	hitSounds = undefined;
	
	stopOnHit = true;
	range = 12;
	
	attackRate = 2.8;
	maxCharges = 8;
	rechargeTime = 1.8;
	killThreshold = 8;
	
}

function melee_shieldAndBaton(level, rarity) : meleeInst(level, rarity) constructor {
	
	name = "Shield and Baton";
	
	damage.kin = 20;
	baseDamage = 20;
	
	hitDelay = 6;
	
	spr = spr_shieldAndBaton;
	attackSprites = [spr_slashUp, spr_slashDown];
	swingSounds = global.data.soundProfiles.swish;
	hitSounds = global.data.soundProfiles.batonHit;

	attackRate = 2.2;
	maxCharges = 5;
	rechargeTime = 1.5;
	killThreshold = 8;
	
	bonusStats.da = 10;
	
}


//enemy and pet weapons
function melee_berthaSlash(level, rarity) : meleeInst(level, rarity) constructor {

	maxCharges = 3;
	damage.kin = 8;
	attackRate = 2.2;
	swingSounds = global.data.soundProfiles.swish;
	hitSounds = global.data.soundProfiles.bulletHitFlesh;

}

function melee_tree(level, rarity) : meleeInst(level, rarity) constructor {

	maxCharges = 2;
	
	attackSprites = [spr_slam];
	
	damage.kin = 12;
	damage.chem = 4;
	
	attackRate = 1.2;
	
	range = 82;
	hitDelay = 12;
	damageInRadius = true;
	stopOnHit = true;
	
	rechargeTime = 2;
	
	swingSounds = global.data.soundProfiles.swish;
	hitSounds = global.data.soundProfiles.hammerHit;
	
}


function melee_symbiontSlash(level, rarity) : meleeInst(level, rarity) constructor {

	maxCharges = 6;
	damage.kin = 10;
	attackRate = 1.8;
	swingSounds = global.data.soundProfiles.swish;
	hitSounds = global.data.soundProfiles.bulletHitFlesh;

}