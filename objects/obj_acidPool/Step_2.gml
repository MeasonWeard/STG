event_inherited();

if (damage.fire > 0) {
	
	var frames = sprite_get_number(spr_littleFlame);
	
	if (!is_array(flames)) {
	
		flames = [];
	
		repeat(6) {
		
			var pt = scr_randomPointInCircle(x, y, radius - 2);
			var subImage = irandom_range(0, frames-1);
			
			var f = instance_create_layer(pt.xx, pt.yy, "Instances", obj_littleGroundEffect);
			f.sprite_index = spr_littleFlame;
			
			array_push(flames, f);
		
		}
	
	}

}

if (lifeTick < 20) deleteFlames();