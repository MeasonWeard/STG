equippedWeapon.damage = damage;

if (delay > 0) {

	delay--;
	
} else {
	
	if (shootTick > 0) {
	
		shootTick --;
	
	} else {
		
		var spare = abs(shootTick);
		shootTick = shootDelay - spare;
		
		var newDir = dir + random_range(-8, 8);
		var proj = scr_projectiles_shootNeutral(x, y, newDir, spd, range);
		
		if (instance_exists(proj)) {
	
			proj.sprite_index = spr_antimatterBullet;
			proj.collisionFunc = scr_effects_explodingProjectile;
			proj.damage = damage;
			proj.explosionRadius = explosionRadius;
			
			if (instance_exists(owner)) {
				proj.faction = owner.faction;
				proj.damageDestructibles = owner.damageDestructibles;
			}
			
			scr_audio_playSoundAt(snd_antimatterShoot, x, y);
			
			projectiles--;
		
		}

		
	}
	
}

if (projectiles <= 0) instance_destroy();