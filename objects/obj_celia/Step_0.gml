event_inherited();

if (alert) {

	var reaim = scr_randomIntermittent(12, 45);

	if (reaim) {

		scr_ai_aimAtTarget(self, target, aimAngle, aimBias);
	
	}
	
	if (is_struct(skills.skill1)) {

		if (scr_timeSlicing_isMyTurn("skillCheck", skillCheckIndex)) {
			scr_char_castSkillAtDist(self, skills.skill1, 400, true);
		}
		
	}

}