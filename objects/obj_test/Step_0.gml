event_inherited();

if (active) {

	var reaim = scr_randomIntermittent(12, 45);

	if (reaim) {

		scr_ai_aimAtTarget(self, target, aimRadius, aimBias);
	
	}

}