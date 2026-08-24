// Inherit the parent event
event_inherited();

height = 75;

sprite_index = spr_forkliftLNoTines;
tines = instance_create_layer(x - 54, y, "Instances", obj_forkliftTines);
tines.sprite_index = spr_forkliftLTines;