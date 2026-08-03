if (setup) {

	setup = false;
	
	if(classNum == 1) showBackButton = false;
	if (classNum == 1) instructionLabel.txt = "Select Major Specialization"; 
	if (classNum == 2) instructionLabel.txt = "Select Minor Specialization";
	
}

hoverHeading = undefined;
hoverDescription = undefined;

if (selectedClass == undefined) {

	selectedLabel.txt = "No specialization selected";
	
} else {

	if (selectedClass == classes.physics) {
		selectedLabel.txt = "Physics";
		heading = "Physics";
		description = physicsTxt;
		major = physMajor;
		minor = physMinor;
	}
	
	if (selectedClass == classes.chemistry) {
		selectedLabel.txt = "Chemistry";
		heading = "Chemistry";
		description = chemistryTxt;
		major = chemMajor;
		minor = chemMinor;
	}
	
	if (selectedClass == classes.biology) {
		selectedLabel.txt = "Biology";
		heading = "Biology";
		description = biologyTxt;
		major = bioMajor;
		minor = bioMinor;
	}
	
	if (selectedClass == classes.engineering) {
		selectedLabel.txt = "Engineering";
		heading = "Engineering";
		description = engineeringTxt;
		major = engMajor;
		minor = engMinor;
	}
	
}