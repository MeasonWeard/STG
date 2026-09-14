if (setup) {

	if (is_undefined(projectConstructor)) exit;
	
	setup = false;

	var tempProject = new projectConstructor();
	
	if (!is_instanceof(tempProject, researchProject)) exit;

	sprite_index = tempProject.icon;
	
	var category = tempProject.category;
	var key = tempProject.key;

	var branch = research.categories[$ category];
	var projects = branch.projects;

	if (variable_struct_exists(projects, key)) {
	
		project = scr_research_loadProject(projects[$ key]);
		projects[$ key] = project;
	
	} else {
	
		project = tempProject;
		projects[$ key] = project;
	
	}
	
	var activeKey = scr_research_getActiveProjectKey(category);
	
	if (activeKey == key) {
		active = true;
	} else {
		active = false;	
	}

}