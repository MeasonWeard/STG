/// @function scr_data_structCopyInto(dest, source)
/// @desc Copies all keys from `source` into `dest`, making deep copies of arrays and structs.
/// @param {struct} dest   Struct to copy into
/// @param {struct} source Struct to copy from
function scr_data_structCopyInto(dest, source) {
	
	if (!is_struct(dest) or !is_struct(source)) return;

	var keys = variable_struct_get_names(source);
	
	for (var i = 0; i < array_length(keys); i++) {
		
		var key = keys[i];
		var val = source[$ key];

		//copy arrays
		if (is_array(val)) {
			
			var len = array_length(val);
			var newArr = array_create(len);
			
			for (var j = 0; j < len; j++) {
				
				var elem = val[j];
				
				if (is_struct(elem)) {
					
					var structCopy = {};
					
					scr_data_structCopyInto(structCopy, elem);
					newArr[j] = structCopy;
					
				} else {
					newArr[j] = elem;
				}
				
			}
			
			dest[$ key] = newArr;
				
			}
		
		//copy structs
		else if (is_struct(val)) {
			
			// if dest already has a struct here, merge into it
		    if (is_struct(dest[$ key])) {
		        scr_data_structCopyInto(dest[$ key], val);
		    }

		    // if not, create a new struct and copy into that
		    else {
		        var newStruct = {};
		        scr_data_structCopyInto(newStruct, val);
		        dest[$ key] = newStruct;
		    }
			
		}
		
		//copy primitives
		else {
			dest[$ key] = val;
		}
		
	}
	
}

/// @function scr_data_arrayCopyInto(dest, source)
/// @desc Appends deep copies of all values from `source` into `dest`.
/// @param {array} dest   Array to copy into
/// @param {array} source Array to copy from
function scr_data_arrayCopyInto(dest, source) {
	
	if (!is_array(dest) or !is_array(source)) return;

	var len = array_length(source);
	
	for (var i = 0; i < len; i++) {
		
		var val = source[i];
		
		// copy arrays
		if (is_array(val)) {
			
			var newArr = [];
			scr_data_arrayCopyInto(newArr, val);
			array_push(dest, newArr);
			
		}
		
		// copy structs
		else if (is_struct(val)) {
			
			var newStruct = {};
			scr_data_structCopyInto(newStruct, val);
			array_push(dest, newStruct);
			
		}
		
		// copy primitives / asset refs / function refs
		else {
			array_push(dest, val);
		}
	}
}

function scr_data_copyInto(dest, source) {

	if (is_array(source)) {
	
		return scr_data_arrayCopyInto(dest, source);
	
	}
	
	if (is_struct(source)) {
		
		return scr_data_structCopyInto(dest, source);
		
	}
	
}

/// @func scr_data_addStructValues(structA, structB)
/// @desc Adds all integer values from structA into structB by matching keys.
///       If a key exists only in structA, it is created in structB with that value.
/// @param {Struct} sourceStruct  Source struct (values to add)
/// @param {Struct} destStruct  Target struct (values are added here)
/// @return {Struct} destStruct (after modification)
function scr_data_addStructValues(sourceStruct, destStruct) {
    
    // Get all keys from structA
    var keys = variable_struct_get_names(sourceStruct);

	
    for (var i = 0; i < array_length(keys); i++) {
		
        var key = keys[i];
        var valueA = variable_struct_get(sourceStruct, key);
	
        // If B already has the key, add to it
        if (variable_struct_exists(destStruct, key)) {
			

            var valueB = variable_struct_get(destStruct, key);
            variable_struct_set(destStruct, key, valueB + valueA);
			
        }
        // Otherwise, create the key in B
        else {

            variable_struct_set(destStruct, key, valueA);
			
        }
    }

    return destStruct;
}

function scr_data_getSetting(setting, defaultVal) {
	
	if (!is_struct(global.gameData)) {
		global.gameData = scr_file_createBlankSave();
	}
	
	if (!is_struct(global.gameData.settings)) {
		global.gameData.settings = {};
	}
	
	var val = scr_data_safeStructGet(global.gameData.settings, setting, defaultVal);
	
	return val;
	
}

//function scr_data_getUpdatedSetting(setting, defaultVal, settingsVersion) {
	
//	if (settingsVersion == global.settingsVersion) {
//		return undefined;
//	}
	
//	var newVal = scr_data_getSetting(setting, defaultVal);
	
//	return newVal;
	
//}

function scr_data_setSetting(setting, value) {
	
	var settings = global.gameData.settings;
	
	variable_struct_set(settings, setting, value);
	
	global.settingsVersion ++;

}

function scr_data_defaultSettings() {

	if (!instance_exists(global.data)) return {};

	var newSettings = {};
	
	var defaults = global.data.defaultSettings;
	
	scr_data_copyInto(newSettings, defaults)
	
	return newSettings;
	
}

function scr_data_safeStructGet(struct, key, defaultVal) {
	
	if (!is_struct(struct)) return defaultVal;
	
	if (!variable_struct_exists(struct, key)) return defaultVal;
	
	return variable_struct_get(struct, key);
	
}

function scr_data_addResource(key, val) {
	
	if (!instance_exists(global.runController)) exit;
	
	var resources = global.runController.resources;

	if (!variable_struct_exists(resources, key)) {
		
		var info = scr_data_getResourceInfo(key);

		resources[$ key] = {
			val : val,
			icon : info.icon,
			name : info.name
		};

		exit;
		
	}
	
	var entry = resources[$ key];
	entry.val += val;
	
}

function scr_data_getResourceInfo(key) {

	static resources = global.data.resources;
	
	var data;
	var newData = {};

	if(variable_struct_exists(resources, key)) {
		
		data = variable_struct_get(resources, key);
		
	} else {
	
		data = resources.def;
	
	}
	
	scr_data_structCopyInto(newData, data);

	return newData;
	
}

//does not mutate the array in place, just returns the reordered one
function scr_data_arrayOrdered(array, order) {

	var orderLen = array_length(order);
	var arrayLen = array_length(array);
	var oldArray = []; 
	array_copy(oldArray, 0, array, 0, arrayLen);
	
	var newArray = [];
	
	//put 'em in order
	for (var i = 0; i < orderLen; i++) {
	
		var key = order[i];
		
		for (var j = arrayLen - 1; j >= 0; j--) {
		
			if (oldArray[j] == key) {
			
				array_push(newArray, key);
				array_delete(oldArray, j, 1);
				arrayLen --;
			
			}
		
		}
	
	}
	
	//just concat the rest
	newArray = array_concat(newArray, oldArray);
	
	return newArray;
	
}

function scr_data_cleanStructArrays(data) {

	var cleaned = {};

	if (!is_struct(data)) return cleaned;

	var keys = variable_struct_get_names(data);
	var keysLen = array_length(keys);

	for (var i = 0; i < keysLen; i++) {

		var key = keys[i];
		var arr = data[$ key];

		if (!is_array(arr)) {
			cleaned[$ key] = arr;
			continue;
		}

		var newArray = [];

		for (var j = 0; j < array_length(arr); j++) {

			var entry = arr[j];

			if (!is_struct(entry)) continue;

			array_push(newArray, entry);

		}

		cleaned[$ key] = newArray;

	}

	return cleaned;

}

function scr_data_getRunController() {

	var rc = variable_global_exists("runController") ? global.runController : noone;
	
	return rc;
	
}

function scr_data_loadItemData(data) {

	if (!is_struct(data)) return undefined;
	if (!variable_struct_exists(data, "type")) return undefined;

	var item;
	
	var lvl = data.lvl;
	var rar = data.rar;
	
	switch (data.type) {
		
		case itemTypes.weapon:
			item = new weaponInst(lvl, rar);
			break;
			
		case itemTypes.gear:
			item = new gearInst(lvl, rar);
			break;

		case itemTypes.gun:
			item = new gunInst(lvl, rar);
			break;

		case itemTypes.melee:
			item = new meleeInst(lvl, rar);
			break;

		case itemTypes.device:
			item = new deviceInst(lvl, rar);
			break;

		case itemTypes.tie:
			item = new tieInst(lvl, rar);
			break;

		case itemTypes.headgear:
			item = new headgearInst(lvl, rar);
			break;

		default:
			return undefined;
	}

	scr_data_structCopyInto(item, data);

	return item;
}

function scr_data_loadItemDataArray(savedArray) {

	var loadedArray = [];

	if (!is_array(savedArray)) return loadedArray;

	for (var i = 0; i < array_length(savedArray); i++) {

		var item = scr_data_loadItemData(savedArray[i]);

		if (!is_undefined(item)) {
			array_push(loadedArray, item);
		}
	}

	return loadedArray;
	
}

function scr_data_loadInventory() {

	var gameData = global.gameData;
	
	var invData = gameData.inventory;
	
	var guns = scr_data_loadItemDataArray(invData.guns);
	var melee = scr_data_loadItemDataArray(invData.melee);
	var devices = scr_data_loadItemDataArray(invData.devices);
	var headgear = scr_data_loadItemDataArray(invData.headgear);
	var ties = scr_data_loadItemDataArray(invData.ties);
	
	return {
		guns: guns,
		melee: melee,
		devices: devices,
		headgear: headgear,
		ties: ties
	}
	
}

function scr_data_loadEquippedGear() {

	var gameData = global.gameData;
	
	var gearData = gameData.playerData.gear;
	
	var gear = {};
	
	var keys = variable_struct_get_names(gearData);
	var keysLen = array_length(keys);
	
	for (var i = 0; i < keysLen; i ++) {
	
		var key = keys[i];
		var item = gearData[$ key];
		
		var newItem = scr_data_loadItemData(item);
		
		gear[$ key] = newItem;
	
	}
	
	return gear;
	
}

function scr_data_loadEquippedWeapons() {

	var gameData = global.gameData;
	
	var weaponData = gameData.playerData.weapons;
	
	var weapons = {};
	
	var keys = variable_struct_get_names(weaponData);
	var keysLen = array_length(keys);
	
	for (var i = 0; i < keysLen; i ++) {
	
		var key = keys[i];
		var item = weaponData[$ key];
		
		var newItem = scr_data_loadItemData(item);
		
		weapons[$ key] = newItem;
	
	}
	
	return weapons;
	
}

function scr_data_loadEquipped() {

	var gear = scr_data_loadEquippedGear();
	var weapons = scr_data_loadEquippedWeapons();
	
	return {
		gear: gear,
		weapons: weapons
	}
	
}
