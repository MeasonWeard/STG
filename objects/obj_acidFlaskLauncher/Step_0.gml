if (instance_exists(owner)) {

	var aimX = owner.aimX;
	var aimY = owner.aimY;
		
	var gunX = owner.gunX;
	var gunY = owner.gunY;
	
	x = gunX;
	y = gunY;
		
	dir = point_direction(gunX, gunY, aimX, aimY);
	
}


if (shootTick > 0) {

	shootTick--;
	
} else {

	var t = (totalProjectiles - projectiles) / max(1, totalProjectiles - 1);
	spd = lerp(maxSpd, minSpd, t);
	var off = dirOffset + totalProjectiles * 0.75;
	
	var flask = instance_create_layer(x, y, "Instances", obj_acidFlask);
	flask.dir = dir + irandom_range(-off, off);
	flask.spd = spd;
	flask.damage = damage;
	flask.radius = radius;
	flask.rot = irandom_range(-8, 8);
	flask.faction = faction;
	flask.poolLife = poolLife;
	flask.sprite_index = spr;
	
	shootTick = shootDelay;
	
	projectiles --;

}

if (projectiles <= 0) instance_destroy();