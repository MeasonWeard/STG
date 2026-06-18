//base class
function skill() constructor {
	
	name = "None";
	icon = spr_icon_blank;
	
	cooldown = 0;
	cooldownTime = 2;
	
	level = 0;
	
	castFunc = undefined;
	
	cast = function(source, target) {
	
		if (!ready()) return false;
		if (!is_callable(castFunc)) return false;
	
		var success = castFunc(source, target);
	
		if (success) {
			cooldown = cooldownTime * 60;
			return true;
		}
	
		return false;
	
	}
	
	tick = function() {
	
		cooldown = max(0, cooldown - 1);
	
	}
	
	ready = function() {
	
		return cooldown <= 0;
	
	}
	
}

function skill_test() : skill() constructor {

	name = "Test";
	
	castFunc = function(source, target) {
		
		if (!instance_exists(source)) return false;
		
		var xx = source.aimX;
		var yy = source.aimY;
		
		instance_create_layer(xx, yy, "Instances", obj_pwooahh);
		
		return true;
		
	}
	
}