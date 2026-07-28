if (instance_exists(owner)) {

	var aimX = owner.aimX;
	var aimY = owner.aimY;
	
	var gunX = owner.gunX;
	var gunY = owner.gunY;
	
	dir = point_direction(gunX, gunY, aimX, aimY);
	
	x = gunX;
	y = gunY;
	
}

if (shooTick > 0) {
	
	shooTick --;
	
} else {
	
	shooTick = shootDelay;
	
	var minLife = life - 8;
	var maxLife = life + 8;
	
	var minDir = dir - 12;
	var maxDir = dir + 12;
	
	var perc = projectiles / maxProjectiles;
	var spd = lerp(minSpd, maxSpd, perc);
	
	var gas = instance_create_layer(x, y, "Instances", obj_gas);
	gas.faction = faction;
	gas.dir = irandom_range(minDir, maxDir);
	gas.life = irandom_range(minLife, maxLife);
	gas.damage = damage;
	gas.spd = spd;
	gas.bioBonus = bioBonus;
	
	var damTick = projectiles * 2 + irandom_range(-1, 1);
	if (damTick > 30) damTick -= 30;
	
	gas.damTick = damTick;
	
	projectiles--;
	
}

if (projectiles <= 0) instance_destroy();