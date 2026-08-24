// Inherit the parent event
event_inherited();

height = 75;

sprite_index = spr_forkliftRNoTines;
tines = instance_create_layer(x + 54, y, "Instances", obj_forkliftTines);
tines.sprite_index = spr_forkliftRTines;