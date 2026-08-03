var showHeading = "";
var showDescription = "";
var showMajor = "";
var showMinor = "";

if (classNum == 2) majorLabel.col = c_grey;

if (hoverHeading != undefined and hoverDescription != undefined) {
	
	showHeading = hoverHeading;
	showDescription = hoverDescription;
	showMajor = hoverMajor;
	showMinor = hoverMinor;
	
} else {
	
	showHeading = heading;
	showDescription = description;
	showMajor = major;
	showMinor = minor;
}

if (showHeading != undefined and showDescription != undefined) {
	
	if (instance_exists(headingLabel)) headingLabel.txt = showHeading;
	if (instance_exists(descLabel)) descLabel.txt = showDescription;
	if (instance_exists(majorLabel)) majorLabel.txt = showMajor;
	if (instance_exists(minorLabel)) minorLabel.txt = showMinor;
}