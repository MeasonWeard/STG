if (delay > 0) {
	delay--;
	exit;
}

currentProjectKey = gameData.research.currentResearch;

if (currentProjectKey != prevCurrentProjectKey) {

	currentProject = scr_research_getProject(currentProjectKey);

}

prevCurrentProjectKey = currentProjectKey;

if (viewedNode == noone and setupViewedNode) {

	setupViewedNode = false;

	with (obj_researchNode) {
	
		if (is_instanceof(project, researchProject)) {
		
			var key = project.key;
			
			if (key == other.currentProjectKey) {
			
				other.viewedNode = self;
				other.viewedProject = project;
			
			}
		
		}
	
	}
	
}