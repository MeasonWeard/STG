event_inherited();

tick--;

if (instance_exists(owner)) {

	if (armed and owner.alternateUse) tick = 0;
	
}

if (tick <= 0) {

	var ex = scr_effects_explosion(x, y, 8);
	ex.damage = damage;
	ex.faction = faction;
	
	var burn = instance_create_layer(x, y, "Instances", obj_burningGround);
	burn.damage = flameDamage;
	burn.life = life;
	burn.faction = faction;
	burn.image_xscale = 2.2;
	burn.image_yscale = 2.2;
	
	instance_destroy();

}

if (tick < 210) {
	sprite_index = spr_thermiteChargeArmed;
	armed = true;
}