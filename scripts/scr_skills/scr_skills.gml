//base class
function skill() constructor {
	
	name = "None";
	icon = spr_icon_blank;
	level = 1;
	
	cooldown = 0;
	cooldownTime = 2;

	castCooldown = 0;
	castCooldownTime = 0.5;

	charges = 1;
	maxCharges = 1;
	
	energyCost = 0;
	
	castFunc = undefined;
	
	setupFunc = undefined;

	cast = function(source) {

		if (!ready()) return false;
		if (!is_callable(castFunc)) return false;
		if (source.energy < energyCost) return false;

		var success = castFunc(source);

		if (success) {

			if (maxCharges > 1) {
				charges--;

				if (charges < maxCharges) {
					cooldown = cooldownTime * 60;
				}
			}
			
			else {
				cooldown = cooldownTime * 60;
			}
			
			if (maxCharges > 1) {
			
				castCooldown = castCooldownTime * 60;
			
			}
			
			source.energy -= energyCost;

			return true;
		}

		return false;

	}

	tick = function() {

		if (maxCharges > 1) {

			if (charges < maxCharges) {

				cooldown = max(0, cooldown - 1);

				if (cooldown <= 0) {

					charges++;

					if (charges < maxCharges) {
						cooldown = cooldownTime * 60;
					}
				}
			}
			
			castCooldown = max(0, castCooldown - 1);

		}
		
		else {

			cooldown = max(0, cooldown - 1);

		}

	}

	ready = function() {

		if (maxCharges > 1) {
			return charges > 0 and castCooldown <= 0;
		}

		return cooldown <= 0;

	}
	
}

function damageProfile() constructor {

	kin = 0;
	fire = 0;
	chem = 0;
	elec = 0;
	rad = 0;
	
}

function skill_test() : skill() constructor {

	name = "Test";
	maxCharges = 2;
	charges = 2;
	
	castFunc = function(source) {
		
		if (!instance_exists(source)) return false;
		
		var xx = source.aimX;
		var yy = source.aimY;
		
		instance_create_layer(xx, yy, "Instances", obj_pwooahh);
		
		return true;
		
	}
	
}

function skill_chainLightning() : skill() constructor {

	name = "Chain Lightning";
	maxCharges = 2;
	charges = 2;
	energyCost = 25;
	range = 800;
	
	damage = undefined;
	
	setupFunc = function(char) {
		
		damage = new damageProfile();
		
		damage.elec = 30 + 15 * level;
		
		damage = scr_stats_calculateDamageProfile(char, damage);
		
	}
	
	castFunc = function(source) {
		
		if (!instance_exists(source)) return false;

		var chains = 2 + level;
		
		var xx = source.aimX;
		var yy = source.aimY;
		
		var nearest = scr_char_getNearest(xx, yy);
		
		if (nearest.id == source.id) return false;
		
		var dist = point_distance(source.x, source.y, nearest.x, nearest.y);
		if (dist > range) return false;
		
		var cx = nearest.x;
		var cy = nearest.y;
		
		var cl = instance_create_layer(cx, cy, "Instances", obj_chainLightning);
		cl.owner = source;
		cl.chainList = [nearest];
		cl.chains = chains;
		cl.damage = damage;
		
		return true;
		
	}
	
}