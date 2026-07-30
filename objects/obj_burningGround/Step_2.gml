// Inherit the parent event
event_inherited();

if (damage.chem > 0) {
	
	var frames = sprite_get_number(spr_littleAcidBubbles);
	
	if (!is_array(bubbles)) {
		
		var radius = sprite_width * 0.5;
		bubbles = [];
		
		repeat(9) {
		
			var pt = scr_randomPointInCircle(x, y, radius - 2);
			var subImage = irandom_range(0, frames-1);
			
			var f = instance_create_layer(pt.xx, pt.yy, "Instances", obj_littleGroundEffect);
			f.sprite_index = spr_littleAcidBubbles;
			
			array_push(bubbles, f);
		
		}
	
	}

}

if (lifeTick < 20) deleteBubbles();