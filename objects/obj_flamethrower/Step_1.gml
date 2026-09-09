if (createJets) {

	createJets = false;

	lifeTick = life * 60;
	
	if (instance_exists(owner)) {
		yOffset = -owner.sprite_height * 0.5;
	}
	
	for (var i = 0; i < jetCount; i++) {

		var jet = instance_create_layer(
			x,
			y,
			"Instances",
			obj_flamethrowerJet
		);

		jet.controller = self;
		jet.owner = owner;
		jet.angleOffset = i * (360 / jetCount);
		jet.damage = damage;
		jet.faction = faction;
		jet.damTick = min(i * 2, jet.damTime * 60);
		jet.damTime = damTime;

		jets[i] = jet;

	}
	
	if (instance_exists(owner)) {

		var sk = scr_skills_findCharSkill("flammable", owner);
	
		if (sk != undefined) {
	
			burnChance = sk.burnChance;
			burnDamage = sk.burnDamage;
	
		}
	
	}
	
}