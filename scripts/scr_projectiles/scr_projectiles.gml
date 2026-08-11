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
	
	proj.height = irandom_range(1, 100);
	//proj.ignoreEnvTick = 1;
	
	proj.checkObstruction = true;

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

function scr_projectiles_shootNeutral(xx, yy, dir, spd, range) {

	var proj = scr_projectiles_create(xx, yy, dir, spd, range, spr_bulletNormal, undefined, noone, undefined);
	return proj;
	
}

function scr_projectiles_shoot(char) {

	//TO DO: it would be good to only set all of these values if projectile create != noone

	var gun = char.equippedWeapon;
	var weaponStats = char.equippedWeaponStats;
	
	if (!is_instanceof(gun, gunInst)) return noone;

	var gunX = char.gunX;
	var gunY = char.gunY;
	var aimX = char.aimX;
	var aimY = char.aimY;
	var faction = char.faction;
	var oa = char.stats.oa;
	var damageDestructibles = char.damageDestructibles;
	var lifeSteal = char.stats.rangedLifeSteal;
	
	var projType = weaponStats.projectileType;
	var spd = weaponStats.spd;
	var sprite = weaponStats.projSprite;
	var destroySprite = weaponStats.projDestroySprite;
	var subimage = weaponStats.projSubimage;
	var imageSpeed = weaponStats.projImageSpeed;
	var damage = weaponStats.damage;
	var range = weaponStats.range;
	var maxAimOff = weaponStats.maxAimOff;
	var recoil = weaponStats.recoil;
	var rot = weaponStats.rot;
	
	var collisionFuncs = [];
	
	if (is_array(weaponStats.collisionFuncs)) collisionFuncs = array_concat(collisionFuncs, weaponStats.collisionFuncs);
	if (is_array(char.bulletFuncs)) collisionFuncs = array_concat(collisionFuncs,char.bulletFuncs);
		
	var dir = point_direction(gunX, gunY, aimX, aimY);
	var aimOff = random_range(-gun.aimOff, gun.aimOff);
	dir += aimOff;
	
	gun.aimOff = min(maxAimOff, gun.aimOff + recoil);

	var proj = noone;

	if (projType == projectileTypes.normal) {
		
		proj = scr_projectiles_create(gunX, gunY, dir, spd, range, sprite, damage, char, undefined);
		
		if (instance_exists(proj)) {
			
			proj.image_angle = dir;
			proj.image_index = subimage;
			proj.image_speed = imageSpeed;
			proj.destroyEffect = destroySprite;
			proj.faction = faction;
			proj.collisionFuncs = collisionFuncs;
			proj.oa = oa;
			proj.damageDestructibles = damageDestructibles;
			proj.rot = choose(rot, -rot);
			proj.lifeSteal = lifeSteal;
			proj.source = char;

			if (rot == 0) {
				proj.image_angle = 0;
			} else {
				proj.image_angle = irandom_range(0, 359);	
			}
			
		}
		
	}
	
	if (projType == projectileTypes.blast) {
	
		var projNum = weaponStats.blastProjectiles;
		var spread = weaponStats.blastSpread;
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
				p.image_index = subimage;
				p.image_speed = imageSpeed;
				p.faction = faction;
				p.collisionFuncs = collisionFuncs;
				p.oa = oa;
				p.damageDestructibles = damageDestructibles;
				p.rot = choose(rot, -rot);
				p.lifeSteal = lifeSteal;
				p.source = char;
				p.destroyEffect = destroySprite;
			
				if (rot == 0) {
					p.image_angle = 0;
				} else {
					p.image_angle = irandom_range(0, 359);	
					
				}
				
			}
			
			proj = p;
		
		}
	
	}
	
	return proj;
	
}

function scr_projectiles_checkObstruction(source, nearby) {
	
	if (!instance_exists(source)) {
		return { hit: false };
	}

	var startX = source.centreX;
	var startY = source.centreY;

	var endX = source.gunX;
	var endY = source.gunY;

	var dir = point_direction(startX, startY, endX, endY);
	var dist = point_distance(startX, startY, endX, endY);

	if (dist <= 0) {
		return { hit: false };
	}

	var len = array_length(nearby);

	var moveX = lengthdir_x(1, dir);
	var moveY = lengthdir_y(1, dir);

	var safeX = startX;
	var safeY = startY;
	
	for (var d = 1; d <= dist; d++) {

		var xx = startX + moveX * d;
		var yy = startY + moveY * d;

		for (var i = 0; i < len; i++) {

			var env = nearby[i];

			if (!instance_exists(env)) continue;
			if (env.onGround) continue;
			if (env.id == source.id) continue;
		
			//skip if higher
			if (height > env.height) {
				//keepDepth = true;
				//depth = env.depth - 1;
				continue;
			}

			if (point_in_rectangle(
				xx, yy,
				env.colLeft,
				env.colTop,
				env.colRight,
				env.colBottom
			)) {

				return {
					hit: true,
					env: env,
					xx: safeX,
					yy: safeY
				};

			}

		}

		safeX = xx;
		safeY = yy;

	}

	return {
		hit: false
	};
	
}

function scr_projectiles_hitEnv(proj, env, hitX, hitY) {

	if (!instance_exists(proj)) return;
	if (!instance_exists(env)) return;

	var profile = env.bulletHitSounds;
	var snd = scr_audio_randomSoundFromProfile(profile);

	if (snd != undefined) {
		audio_play_sound_at(
			snd,
			proj.x,
			proj.y,
			0,
			MIN_FALLOFF_BULLETHIT,
			MAX_FALLOFF_BULLETHIT,
			FALLOFF_FACTOR_BULLETHIT,
			false,
			0
		);
	}

	proj.active = false;

	var eff = instance_create_layer(
		hitX,
		hitY,
		"Instances",
		obj_bulletEffect
	);

	eff.sprite_index = proj.destroyEffect;
	eff.image_angle = proj.image_angle;

	var hitTop = (
		proj.dir > 180
		and proj.dir < 360
		and proj.y <= env.colTop + proj.spd
	);

	if (hitTop) {
		eff.depth = env.depth + 1;
	} else {
		eff.depth = env.depth - 1;
	}

	var funcsLen = array_length(proj.collisionFuncs);

	for (var i = 0; i < funcsLen; i++) {

		var func = proj.collisionFuncs[i];

		if (is_callable(func)) {
			func(proj);
		}

	}

	if (is_callable(env.bulletHitFunc)) {
		env.bulletHitFunc(proj, env);
	}

	if (env.smashable) {
		env.smashed = true;
	}

}