if (setup) {

	setup = false;
	
	if (is_undefined(projectConstructor)) exit;

	var tempProject = new projectConstructor();
	
	if (!is_instanceof(tempProject, researchProject)) exit;

	sprite_index = tempProject.icon;
	var category = tempProject.category;
	var key = tempProject.key;

	var branch = research[$ category];

	if (variable_struct_exists(branch.projects, key)) {
	
		project = scr_research_loadProject(branch.projects[$ key]);
		branch.projects[$ key] = project;
	
	} else {
	
		project = tempProject;
		branch.projects[$ key] = project;
	
	}

}