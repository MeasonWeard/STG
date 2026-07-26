event_inherited();

if (!active) {

	if (image_index == image_number - 1) {
		sprite_index = spr_burnedGround;
		active = true;
	}
	
}

//image_xscale = ((radius * 2) / sprite_get_width(sprite_index)) * xSide;
//image_yscale = ((radius * 2) / sprite_get_height(sprite_index)) * ySide;