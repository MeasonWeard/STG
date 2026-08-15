event_inherited();

image_speed = -dir * (spd * 1.83);

var hash = global.stageController.charHash;

var player = global.player;

if (instance_exists(player)) {

	if (point_in_rectangle(player.x, player.y, colLeft, colTop, colRight, colBottom)) {
	
		player.xspd += dir * spd;
	
	}
	
}


//for (var k = 0; k < 9; k++) {
	
//	var key = charHashKeys[k];
	
//	if (!variable_struct_exists(hash, key)) continue;
	
//	var nearby = hash[$ key];
//	var len = array_length(nearby);

//	for (var i = 0; i < len; i++) {
	
//		var char = nearby[i];
	
//		if (!instance_exists(char)) continue;
		
//		if (point_in_rectangle(char.x, char.y, colLeft, colTop, colRight, colBottom)) {
		
//			char.x += dir * spd;
		
//		}
	
		
//	}
	
//}

