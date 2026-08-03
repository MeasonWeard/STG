function melee_cleaver(level, rarity) : meleeInst(level, rarity) constructor {

	damage.kin = 25;
	baseDamage = 25;
	
	attackRate = 2.4;
	damage.kin = 35;
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
	range = 14;
	
	attackRate = 2.8;
	maxCharges = 8;
	rechargeTime = 1.8;
	killThreshold = 8;
	
}

//enemy and pet weapons
function melee_berthaSlash(level, rarity) : meleeInst(level, rarity) constructor {

	maxCharges = 3;
	damage.kin = 12;
	attackRate = 2.2;
	swingSounds = global.data.soundProfiles.swish;
	hitSounds = global.data.soundProfiles.bulletHitFlesh;

}

//enemy weapons
function melee_symbiontSlash(level, rarity) : meleeInst(level, rarity) constructor {

	maxCharges = 6;
	damage.kin = 10;
	attackRate = 1.8;
	swingSounds = global.data.soundProfiles.swish;
	hitSounds = global.data.soundProfiles.bulletHitFlesh;

}