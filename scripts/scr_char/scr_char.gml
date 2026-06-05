function scr_char_isFriendly(source, target) {

	if (!instance_exists(source)) return false;
	if (!instance_exists(target)) return false;

	return source.faction == target.faction;
	
}

function scr_char_fleshExplosion(char){
	
	var spr = char.sprite_index;
	
	var w = sprite_get_width(spr) * 0.5;
	var h = sprite_get_height(spr) * 0.5;
	
	var xx = char.x;
	var yy = char.y;

	// diamond points (approx, centred on origin)
	var topX = xx;
	var topY = yy - h;

	var bottomX = xx;
	var bottomY = yy + h; //* 0.75;
	
	var midY = (bottomY + topY) * 0.5;

	var leftX = xx - w;
	var leftY = yy;

	var rightX = xx + w;
	var rightY = yy;
	
	var col = char.bloodCol;
	var force = 12;
	var particles = 10;
	var rad = 6;
	var splits = 2;
	var life = 8;
	
	var dels = [0, 1, 3, 5];
	dels = array_shuffle(dels);
	
	scr_effects_bloodSplatter(topX, midY, col, force, 15, 7, 0, life);
	
	var b1 = scr_effects_bloodSplatter(topX, topY, col, force, particles, rad, splits, life);
	var b2 = scr_effects_bloodSplatter(bottomX, bottomY, col, force, particles, rad, splits, life);
	var b3 = scr_effects_bloodSplatter(leftX, leftY, col, force, particles, rad, splits, life);
	var b4 = scr_effects_bloodSplatter(rightX, rightY, col, force, particles, rad, splits, life);

	b1.delay = dels[0];
	b2.delay = dels[1];
	b3.delay = dels[2];
	b4.delay = dels[3];

}

function scr_char_damage(char, amount, type, ignoreArmour) {
	
	if (!instance_exists(char)) return 0;
	
	if (!ignoreArmour and char.armour > 0) {
	
		char.armour -= 1;
		return 0;
	
	}
	
	var lost = min(char.hp, amount);
	
	char.hp = max(char.hp - amount, 0);
	
	return lost;
	
}

function scr_char_heal(char, amount) {

	if (!instance_exists(char)) return 0;
	
	var missing = char.maxHp - char.hp;
	
	char.hp = min(char.hp + amount, char.maxHp);
	
	return min(amount, missing);
	
}