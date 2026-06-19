//base class
function skill() constructor {
	
	name = "None";
	icon = spr_icon_blank;

	cooldown = 0;
	cooldownTime = 2;

	charges = 1;
	maxCharges = 1;
	
	castCooldown = 0;
	castCooldownTime = 0.5;

	level = 0;

	castFunc = undefined;

	cast = function(source, target) {

		if (!ready()) return false;
		if (!is_callable(castFunc)) return false;

		var success = castFunc(source, target);

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

function skill_test() : skill() constructor {

	name = "Test";
	maxCharges = 2;
	charges = 2;
	
	castFunc = function(source, target) {
		
		if (!instance_exists(source)) return false;
		
		var xx = source.aimX;
		var yy = source.aimY;
		
		instance_create_layer(xx, yy, "Instances", obj_pwooahh);
		
		return true;
		
	}
	
}