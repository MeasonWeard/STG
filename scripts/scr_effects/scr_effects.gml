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

function scr_effects_explodingProjectile(proj) {

	var rad = 75;
	
	if (variable_instance_exists(proj, "explosionRadius")) rad = proj.explosionRadius;

	var explosion = instance_create_layer(proj.x, proj.y, "Instances", obj_explosion);
	
	explosion.radius = rad;
	explosion.sounds = global.data.soundProfiles.microMissile;
	explosion.damage = proj.damage;
	
}