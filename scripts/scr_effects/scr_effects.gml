function scr_effects_bloodSplatter(xx, yy, col, force, particles, radius, splits, life){

	var inst = instance_create_layer(xx, yy, "Instances", obj_bloodSplatter);
	
	inst.x = xx;
	inst.y = yy;
	inst.col = col;
	inst.particles = particles;
	inst.rad = radius;
	inst.splits = splits;
	inst.life = life;
	
	var effectiveForce = force;

	if (effectiveForce > 20) {
		effectiveForce = 20 + power(effectiveForce - 20, 0.7) * 0.5;
	}

	inst.force = effectiveForce;
	
	return inst;

}

function scr_effects_bulletHitFlesh(source, char) {
	
	if (!instance_exists(source) or !instance_exists(char)) exit;
	//var force = source.damage * 0.75;
	var force = 10;
	var radius = 2 + force * 0.05;
	var particles = ceil(8 + force * 0.1);
	scr_effects_bloodSplatter(source.x, source.y, char.bloodCol, force, particles, radius, 3, 12);
	
}

function scr_effects_explosion(xx, yy, strength) {
	
	var rad = 20 * strength;
	var dam = 10 * strength;
	
	var damage = new damageProfile();
	damage.kin = dam;
	
	//scr_stats_calculateDamageProfileWeapon()

	var explosion = instance_create_layer(xx, yy, "Instances", obj_explosion);
	
	explosion.radius = rad;
	explosion.sounds = [snd_explosion];
	explosion.damage = damage;
	
	return explosion;
	
}

function scr_effects_bioBomb(char) {
	
	if (!variable_instance_exists(char, "bioBombData")) exit;

	var dat = char.bioBombData;
	
	var hp = char.maxHp;
	var damPerc = dat.damPerc;
	var pools = dat.pools;
	var poolDam = dat.poolDam;
	var poolLife = dat.poolLife;
	var poolRad = dat.poolRadius;
	
	var dam = hp * (damPerc * 0.01);
	var rad = clamp(10 * dam, 20, 240);
	
	var damage = new damageProfile();
	damage.chem = dam;
	
	if (variable_struct_exists(char.bioBombData, "radDamPerc")) {
	
		var dec = char.bioBombData.radDamPerc * 0.01;
		damage.rad = ceil(damage.chem * dec);
	
	}
	
	var explosion = instance_create_layer(char.x, char.y, "Instances", obj_explosion);
	
	explosion.radius = rad;
	explosion.sounds = [snd_fleshExplode1, snd_fleshExplode2, snd_fleshExplode3];
	explosion.damage = damage;
	
	explosion.faction = char.faction;
	explosion.col = c_green;
	
	repeat(pools) {
	
		var pt = scr_randomPointInCircle(char.x, char.y, rad);

		var pool = instance_create_layer(pt.xx, pt.yy, "Instances", obj_acidPool);
		pool.faction = char.faction;
		pool.life = poolLife;
		pool.damage = poolDam;
		pool.radius = poolRad;
		
	}
	
	return explosion;
	
}

function scr_effects_explodingProjectile(proj) {

	var rad = 75;
	
	if (variable_instance_exists(proj, "explosionRadius")) rad = proj.explosionRadius;

	var explosion = instance_create_layer(proj.x, proj.y, "Instances", obj_explosion);
	
	explosion.radius = rad;
	explosion.sounds = global.data.soundProfiles.microMissile;
	explosion.damage = proj.damage;
	explosion.faction = proj.faction;
	
}

function scr_effects_acidicBullet(att) {
	
	if (!instance_exists(att.source)) exit;
	
	var sk = scr_skills_findCharSkill("acidicBullets", att.source);
	
	if (is_undefined(sk)) exit;
	
	var chance = sk.chance;
	var damage = sk.damage;
	var radius = sk.radius;
	var life = sk.life;
	
	if (!scr_random_chance(chance)) exit;
	
	var xx = att.x;
	var yy = att.y;
	
	if (object_is_ancestor(att.object_index, obj_meleeAttack)) {
		xx = att.hitX;
		yy = att.hitY;
	}
	
	var pool = instance_create_layer(xx, yy, "Instances", obj_acidPool);
	
	pool.damage = damage;
	pool.radius = radius;
	pool.life = life;
	pool.faction = att.source.faction;
	
}

function scr_effects_incendiaryBullet(att) {

	if (!instance_exists(att.source)) exit;
	
	var sk = scr_skills_findCharSkill("incendiaryBullets", att.source);
	
	if (is_undefined(sk)) exit;
	
	var chance = sk.chance;
	var damage = sk.damage;
	var radius = sk.radius;
	var life = sk.life;
	
	if (!scr_random_chance(chance)) exit;
	
	var xx = att.x;
	var yy = att.y;
	
	if (object_is_ancestor(att.object_index, obj_meleeAttack)) {
		xx = att.hitX;
		yy = att.hitY;
	}
	
	var pool = instance_create_layer(xx, yy, "Instances", obj_burningGround);
	
	pool.damage = damage;
	pool.radius = radius;
	pool.life = life;
	pool.faction = att.source.faction;
	
}

function scr_effects_radioactiveBullet(att) {
		
	if (!instance_exists(att.source)) exit;
	
	var sk = scr_skills_findCharSkill("radioactiveBullets", att.source);
	
	if (is_undefined(sk)) exit;
	
	var chance = sk.chance;
	var damage = sk.damage;
	var radius = sk.radius;
	
	if (!scr_random_chance(chance)) exit;
	
	var xx = att.x;
	var yy = att.y;
	
	if (object_is_ancestor(att.object_index, obj_meleeAttack)) {
		xx = att.hitX;
		yy = att.hitY;
	}
	
	var flash = instance_create_layer(xx, yy, "Instances", obj_radiationFlash);
	
	flash.damage = damage;
	flash.radius = radius;
	flash.faction = att.source.faction;
	
}

function scr_effects_electricBullet(att) {
		
	if (!instance_exists(att.source)) exit;
	
	var sk = scr_skills_findCharSkill("electricBullets", att.source);
	
	if (is_undefined(sk)) exit;
	
	var chance = sk.chance;
	var damage = sk.damage;
	var targets = sk.targets;
	
	if (!scr_random_chance(chance)) exit;
	
	var xx = att.x;
	var yy = att.y;
	
	if (object_is_ancestor(att.object_index, obj_meleeAttack)) {
		xx = att.hitX;
		yy = att.hitY;
	}
	
	var shock = instance_create_layer(xx, yy, "Instances", obj_shock);
	
	shock.damage = damage;
	shock.targets = targets;
	shock.faction = att.source.faction;
	
}