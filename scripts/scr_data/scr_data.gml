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

function scr_data_getUpdatedSetting(setting, defaultVal) {
	
	if (!global.settingsDirty) {
		return undefined;
	}
	
	var newVal = scr_data_getSetting(setting, defaultVal);
	
	return newVal;
	
}

function scr_data_setSetting(setting, value) {
	
	var settings = global.gameData.settings;
	
	variable_struct_set(settings, setting, value);
	
	global.settingsDirty = true;
	
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

	var resources = global.runController.resources;
	
	var oldVal = resources[$ key];
	
    if (is_undefined(oldVal)) oldVal = 0;

    resources[$ key] = oldVal + val;	
	
}