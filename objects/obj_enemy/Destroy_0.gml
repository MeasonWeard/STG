if (instance_exists(ghost)) instance_destroy(ghost);

var num = irandom_range(2, 4);

repeat(num) {
	scr_items_spawn(obj_res_data, x, y, 10, true);
}

num = choose(0,1);

repeat(num) {
	scr_items_spawn(obj_res_metals, x, y, 10, true);
}

num = choose(0,1);

repeat(num) {
	scr_items_spawn(obj_res_polymers, x, y, 10, true);
}

num = choose(0,0,0,0,1,2);

repeat(num) {
	scr_items_spawn(obj_res_fissiles, x, y, 10, true);
}