rc = global.researchController;
txt = "Level Up";
leftKey = vk_enter;

visibleWhenInactive = false;

leftFunc = function() {
	
	var rc = global.researchController;
	var cp = rc.currentProject;
	
	if (is_struct(cp)) {
		
		var ready = scr_research_hasRequirements(cp);
		
		if (ready) {
			
			scr_research_levelUp(cp);
			
			audio_play_sound(snd_levelUp, 0, false);
			
			rc.reset();
			
		}
	
	}
	
}

constantFunc = function() {

	var cp = global.researchController.currentProject;

	if (!is_struct(cp)) {
		
		active = false;
	
	} else {
	
		if (scr_research_hasRequirements(cp)) {
			active = true;
		} else {
			active = false;	
		}
	
	}
	
}