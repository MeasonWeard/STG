event_inherited();

if (movedThisStep) {

	if (instance_exists(decoration)) {
	
		decoration.depth = depth - 1;
		decoration.x = x + sprite_width * 0.5;
		decoration.y = y - sprite_height * spriteYoffset;
		
	}

}