if (instance_exists(owner)) {
	
	x = owner.x;
	y = owner.y;
	faction = owner.faction;
	
	if (cooldown == 0 and (owner.hp < prevHp or owner.shield < prevShield)) {
		
		if (scr_random_chance(chance)) {
		
			cooldown = 8;
		
			var ex = instance_create_layer(x, y, "Instances", obj_explosion);
			var bg = instance_create_layer(x, y, "Instances", obj_burningGround);
			
			ex.faction = faction;
			ex.damage = expDam;
			ex.radius = expRadius;
			ex.col = c_orange;
			ex.sounds = [snd_volatile];
			
			bg.faction = faction;
			bg.damage = bgDam;
			bg.life = bgLife;
			bg.radius = bgRadius;
		
		}
		
	}
	

	prevHp = owner.hp;
	prevShield = owner.shield;

	if (cooldown > 0) cooldown --;
	
} else {

	instance_destroy();
	
}