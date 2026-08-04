global.displayController = self;

#macro INTERNAL_WIDTH 1920
#macro INTERNAL_HEIGHT 1080

application_surface_enable(true);
gpu_set_texfilter(true);

global.guiScaling = false;
global.integerScaling = true;

//default window size
var res = [1920,1080];//global.gameData.settings.res;
var windowed = true;

//user selected window size
if (variable_global_exists("gameData") and is_struct(global.gameData)) {
	
	res = global.gameData.settings.res;
	windowed =  global.gameData.settings.windowed;
	
}

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

refreshScaling = false;
scaleGUI = true;