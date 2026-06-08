function scr_projectiles_get() {
	
	var pool = global.stageController.projectilePool;
	var len = global.stageController.procectilePoolLen;
	
	for (var i = 0; i < len; i++) {
		
		var proj = pool[i];
		
		if (!proj.active) {
			return proj;
		}
		
	}
	
	return noone;
	
}

function scr_projectiles_create(xx, yy, dir, spd, range, sprite, damage, source, additionalData) {

	var proj = scr_projectiles_get();
	
	if (proj == noone) return noone;
	
	//argument values set
	proj.active = true;
	proj.x = xx;
	proj.y = yy;
	proj.dir = dir;
	proj.spd = spd;
	proj.sprite_index = sprite;
	proj.damage = damage;
	proj.source = source;
	proj.rangeLeft = range;

	//values to always reset

	//additional data
	if (is_struct(additionalData)) {
		
		var keys = variable_struct_get_names(additionalData);
		var keysLen = array_length(keys);
		
		for (var i = 0; i < keysLen; i++) {
		
			var field = keys[i];
			var val = variable_struct_get(additionalData, field);
			variable_instance_set(proj, field, val);
		
		}
		
	}
	
	//return
	return proj;

}

function scr_projectiles_shoot(char) {

	//TO DO: it would be good to only set all of these values if projectile create != noone

	var gun = char.gun;
	var gunStats = char.gunStats;

	var gunX = char.gunX;
	var gunY = char.gunY;
	var aimX = char.aimX;
	var aimY = char.aimY;
	var faction = char.faction;
	
	var projType = gunStats.projectileType;
	var spd = gunStats.spd;
	var sprite = gunStats.projSprite;
	var damage = gunStats.damage;
	var range = gunStats.range;
	var collisionFunc = gunStats.collisionFunc;
	var maxAimOff = gunStats.maxAimOff;
	var recoil = gunStats.recoil;
	
	var dir = point_direction(gunX, gunY, aimX, aimY);
	var aimOff = random_range(-gun.aimOff, gun.aimOff);
	dir += aimOff;
	
	gun.aimOff = min(maxAimOff, gun.aimOff + recoil);

	var proj = noone;

	if (projType == projectileTypes.normal) {
		
		proj = scr_projectiles_create(gunX, gunY, dir, spd, range, sprite, damage, char, undefined);
		
		if (instance_exists(proj)) {
			proj.image_angle = dir;
			proj.faction = faction;
			proj.collisionFunc = collisionFunc;
		}
		
	}
	
	if (projType == projectileTypes.blast) {
	
		var projNum = gunStats.blastProjectiles;
		var spread = gunStats.blastSpread;
		var jiggle = spread * 0.5;
	
		var step = 0;
		if (projNum > 1) step = spread / (projNum - 1);
	
		for (var i = 0; i < projNum; i++) {
		
			var angle;
		
			// center the spread around dir
			if (projNum > 1) {
				angle = dir - spread * 0.5 + (i * step);
			} else {
				angle = dir;
			}
		
			// add randomness
			angle += random_range(-jiggle, jiggle);
			
			var spdVariance = spd * 0.15;
			var newSpd = random_range(spd - spdVariance, spd + spdVariance);
		
			var p = scr_projectiles_create(
				gunX, gunY,
				angle,
				newSpd,
				range,
				sprite,
				damage,
				char,
				undefined
			);
			
			if (p != noone) {
				p.image_angle = angle;
				p.faction = faction;
				p.collisionFunc = collisionFunc;
			}
			
			proj = p;
		
		}
	
	}
	
	return proj;
	
}