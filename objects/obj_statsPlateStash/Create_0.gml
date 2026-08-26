owner = noone;
player = global.player;
data = global.data;
stashController = global.stashController;
depth = layers.ui2;

setup = true;
itemsDirty = false;
getStats = false;

txtCore = "";
txtDef = "";
txtOff = "";

tabs = ["core", "offense", "defense"];
tabIndex = 0;
tab = "core";

formatTick = 0;

statsLeft = x;
statsTop = y;
statsRight = statsLeft + 400;
statsBottom = statsTop + 400;