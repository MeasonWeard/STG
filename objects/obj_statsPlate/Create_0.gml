owner = noone;
player = global.player;
data = global.data;
depth = layers.ui2;

txt = "";

setup = true;

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

device1 = undefined;
device2 = undefined;
tie = undefined;
headgear = undefined;

closeDelay = 12;