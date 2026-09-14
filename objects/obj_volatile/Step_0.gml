var trigger = false;

if (instance_exists(owner)) {
	
	x = owner.x;
	y = owner.y;
	faction = owner.faction;
	
	if (owner.hp < prevHp or owner.shield < prevShield) {
		trigger = true;
	}
	
	prevHp = owner.hp;
	prevShield = owner.shield;
	
} else {
	
	trigger = true;
	
}

if (trigger and cooldown == 0) {
	
	if (scr_random_chance(chance)) {
		
		cooldown = 8;
		
		var ex = instance_create_layer(x, y, "Instances", obj_explosion);
		var bg = instance_create_layer(x, y, "Instances", obj_burningGround);
		
		ex.faction = faction;
		ex.damage = expDam;
		ex.radius = expRadius;
		ex.col = c_orange;
		ex.sounds = [snd_volatile];
		
		bg.source = owner;
		bg.caster = caster;
		bg.faction = faction;
		bg.damage = bgDam;
		bg.life = bgLife;
		bg.radius = bgRadius;
		
	}
	
}

if (cooldown > 0) cooldown--;

if (!instance_exists(owner)) {
	instance_destroy();
}