if (setup) {

	setup = false;
	
	var skillTemplate = undefined;
	if (is_callable(const)) skillTemplate = new const();
	
	var found = false;
	
	if (is_struct(selectedClass) and is_struct(skillTemplate)) {
	
		var skills = selectedClass.unlockedSkills;
		var skillsLen = array_length(skills);
		
		if (is_array(skills)) {
		
			for (var i = 0; i < skillsLen; i++) {
		
				var sk = skills[i];
				if (!is_struct(sk)) continue;
			
				if (sk.name == skillTemplate.name) {
					thisSkill = sk;
					found = true;
					break;
				}
		
			}
		
		}
	
	}
	
	if (!found) thisSkill = skillTemplate;

}