if (delay > 0) {
	delay--;
	exit;
}

if (instance_exists(rc)) {

	viewedNode = rc.viewedNode;
	viewedProject = rc.viewedProject;
	
	currentProject = rc.currentProject;

	if (is_struct(currentProject) and currentProject != prevCurrentProject) {

		currentProgress = currentProject.progress;
		currentIcon = currentProject.icon;
	
	}

	prevCurrentProject = currentProject;
	
}