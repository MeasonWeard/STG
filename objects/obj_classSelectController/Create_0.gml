global.classSelectController = self;

playerData = global.gameData.playerData;
selectedLabel = noone;
headingLabel = noone;
descLabel = noone;
instructionLabel = noone;
majorLabel = noone;
minorLabel = noone;

class1 = playerData.class1;

if (instance_exists(global.player)) instance_destroy(global.player);
scr_char_removeAllPets();

setup = true;

showBackButton = true;

classNum = is_undefined(class1) ? 1 : 2;

selectedClass = undefined;

physicsTxt = scr_file_getTextFromFile("physics");
chemistryTxt = scr_file_getTextFromFile("chemistry");
biologyTxt = scr_file_getTextFromFile("biology");
engineeringTxt = scr_file_getTextFromFile("engineering");

var tempPhys = new class_physics();
var tempChem = new class_chemistry();
var tempBio = new class_biology();
var tempEng = new class_engineering();

var physBonusesTxt = scr_class_formatClassBonuses(tempPhys);
var chemBonusesTxt = scr_class_formatClassBonuses(tempChem);
var bioBonusesTxt = scr_class_formatClassBonuses(tempBio);
var engBonusesTxt = scr_class_formatClassBonuses(tempEng);

physMajor = physBonusesTxt.major;
physMinor = physBonusesTxt.minor;

chemMajor = chemBonusesTxt.major;
chemMinor = chemBonusesTxt.minor;

bioMajor = bioBonusesTxt.major;
bioMinor = bioBonusesTxt.minor;

engMajor = engBonusesTxt.major;
engMinor = engBonusesTxt.minor;

heading = "";
description = "";
major = "";
minor = "";

hoverHeading = undefined;
hoverDescription = undefined;
hoverMajor = undefined;
hoverMinor = undefined;