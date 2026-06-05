global.displayController = self;

#macro INTERNAL_WIDTH 1920
#macro INTERNAL_HEIGHT 1080

application_surface_enable(true);
gpu_set_texfilter(true);

// user setting:
global.guiScaling = false;   // or true

// user-selected window size:
var res = global.gameData.settings.res;
var windowed = global.gameData.settings.windowed;
var w = res[0];
var h = res[1];

global.window_w = w;
global.window_h = h;

display_set_gui_maximize(true);
display_set_gui_size(INTERNAL_WIDTH, INTERNAL_HEIGHT);

// start windowed:
window_set_fullscreen(!windowed);
window_set_size(global.window_w, global.window_h);
window_center();

scaleGUI = true;