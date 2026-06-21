closeDelay = max(closeDelay - 1, 0);

if ((keyboard_check_pressed(vk_tab) or keyboard_check_pressed(vk_escape)) and closeDelay == 0) instance_destroy();