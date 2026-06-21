if (instance_exists(ghost)) instance_destroy(ghost);

repeat(4) {
	scr_items_spawn(obj_res_data, x, y, 10, true);
}