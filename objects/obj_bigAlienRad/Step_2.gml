// Inherit the parent event
event_inherited();

if (setupIr > 0) { 
	
	setupIr --;
	
} else if (setupIr == 0) {

	setupIr = -1;

	var efflvl = (max(0, level - 10) div 4);
	if (efflvl > 9) effLvl = 9;

	var irDamage = new damageProfile();
	irDamage.rad = 10 + efflvl * 4;
	irDamage = scr_stats_calculateSkillDamage(self, irDamage, ["rad"]);
			
	var irFreq = 0.25 + efflvl * 0.0125;
	var irRadius = 175 + efflvl * 10;
	
	var ir = instance_create_layer(x, y, "Instances", obj_irradiated);
	
	ir.damage = irDamage;
	ir.freq = irFreq;
	ir.radius = irRadius;
	ir.owner = self;

}