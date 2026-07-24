if (hazardSetup) {

	if (is_real(life)) lifeTick = life * 60;

	hazardSetup = false;
	
	damTick = irandom_range(0, damTime * 60);

	scr_movement_updateCollisionHitBox(self);
	scr_movement_updateCollisionHitBox(self);
	
	prevXscale = image_xscale;
	prevYscale = image_yscale;
	
}

if (image_xscale != prevXscale or image_yscale != prevYscale) {

	scr_movement_updateCollisionHitBox(self);
	scr_movement_updateCollisionHitBox(self);
	
}

prevXscale = image_xscale;
prevYscale = image_yscale;