owner = noone;
player = global.player;
data = global.data;
depth = layers.ui2;

txtCore = "";
txtDef = "";
txtOff = "";

tabs = ["core", "offense", "defense"];
tabIndex = 0;
tab = "core";

formatTick = 0;

cam = view_camera[0];
camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);
camH = camera_get_view_height(cam)
camW = camera_get_view_width(cam);

statsLeft = camX + 20;
statsTop = camY + 20;
statsRight = statsLeft + 400;
statsBottom = statsTop + 800;

gearLeft = statsRight + 20;
gearRight = gearLeft + 600;
gearTop = statsTop;
gearBottom = statsBottom;

gearSlotSize = 96;
gearSlotGap = gearSlotSize + 16;
gearX = gearLeft + 32;
gearY = gearTop + 32;

weaponX = gearLeft + 256;
weaponY = gearY;

device1 = undefined;
device2 = undefined;
tie = undefined;
headgear = undefined;
coat = undefined;

weapon = undefined;

keyDelay = 12;