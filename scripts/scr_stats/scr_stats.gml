function scr_stats_calculateStat(flat, perc) {

	var dec = perc * 0.01;
	var add = dec * flat;
	
	return flat + add;
	
}

function scr_stats_calculateDamageRange(dam) {

	if (dam < 1) return {
		minDam: 0,
		maxDam: 0
	};

	var minDam = floor(dam * 0.8);
	var maxDam = ceil(dam * 1.2);
	
	return {
		minDam: minDam,
		maxDam: maxDam
	}
	
}



function scr_stats_calculateResistanceRange(res) {

	var minRes = floor(res / 5);
	var maxRes = res;
	
	return {
		minRes: minRes,
		maxRes: maxRes
	}
	
}

