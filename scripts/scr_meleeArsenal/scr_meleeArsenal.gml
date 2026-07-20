function melee_cleaver(level, rarity) : meleeInst(level, rarity) constructor {

	damage.kin = 25;
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
	
	damage.kin = 50;
	
}

function melee_prod(level, rarity) : meleeInst(level, rarity) constructor {
	
	name = "Prod";
	spr = spr_prod;
	attackSprites = [spr_prodAttack];
	swingSounds = global.data.soundProfiles.prod;
	hitSounds = undefined;
	
	stopOnHit = true;
	range = 16;
	
	attackRate = 2.8;
	maxCharges = 8;
	rechargeTime = 1.8;
	killThreshold = 10;
	
	damage.kin = 0;
	damage.elec = 15;
	
}

//enemy weapons
function melee_berthaSlash(level, rarity) : meleeInst(level, rarity) constructor {

	maxCharges = 3;
	damage.kin = 12;
	swingSounds = global.data.soundProfiles.swish;
	hitSounds = global.data.soundProfiles.bulletHitFlesh;

}