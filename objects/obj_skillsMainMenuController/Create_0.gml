if (instance_exists(global.player)) global.player.active = false;

global.skillsMainMenuController = self;

playerData = global.gameData.playerData;

class1 = playerData.class1;
class2 = playerData.class2;

level = playerData.level;

label1 = noone;
label2 = noone;

classButton1 = noone;
classButton2 = noone;

setup = true;