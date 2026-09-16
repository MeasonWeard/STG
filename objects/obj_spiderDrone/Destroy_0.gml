// Inherit the parent event
event_inherited();

var val = choose(1,2);
scr_items_drop(obj_res_metals, x, y, 10, val, true, level * 2, 1);
scr_items_drop(obj_res_chip, x, y, 5, 1, true, level * 2, 1);

scr_items_drop(obj_res_fissiles, x, y, 0.25, 1, true, level, 1);