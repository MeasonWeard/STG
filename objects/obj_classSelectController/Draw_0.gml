var showHeading = "";
var showDescription = "";

if (hoverHeading != undefined and hoverDescription != undefined) {
	
	showHeading = hoverHeading;
	showDescription = hoverDescription;
	
} else {
	
	showHeading = heading;
	showDescription = description;
	
}

if (showHeading != undefined and showDescription != undefined) {
	
	if (instance_exists(headingLabel)) headingLabel.txt = showHeading;
	if (instance_exists(descLabel)) descLabel.txt = showDescription;
	
}