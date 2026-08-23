// Inherit the parent event
event_inherited();

if (alert) {

	var reaim = scr_randomIntermittent(12, 45);

	if (reaim) {

		scr_ai_aimAtTarget(self, target, aimAngle, aimBias);
	
	}
	
	if (scr_timeSlicing_isMyTurn("skillCheck", skillCheckIndex)) {
		warning.radius = skills.skill1.radius;
		scr_char_castSkillAtDist(self, skills.skill1, 150, true, warning);
	}

}