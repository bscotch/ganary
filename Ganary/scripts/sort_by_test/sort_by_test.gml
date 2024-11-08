		function string_to_path_array(path_string) {
			var path = string_split(path_string, "/");
			
			var temp_path = [];
			for ( var i = 0; i < array_length(path); i++){
				var this_path_key = path[i];
				if (this_path_key == "") {
					continue;
				}
				
				var digits = string_digits(this_path_key);
				if digits == this_path_key {
					array_push(temp_path, real(this_path_key));
				}
				else array_push(temp_path, this_path_key);
			}
			return temp_path;
		}

		function get_path_value(parent, path, return_if_not_found=undefined, throw_error_if_invalid=false, __current_path_pos=0){
			if (__current_path_pos == 0) {
				// Clean up the path and convert it to a searchable format.
				if is_string(path) {
					path = string_to_path_array(path);
				}
				else if is_real(path) {
					path = [path];
				}
			}
			
			if is_undefined(parent) {
				if throw_error_if_invalid {
					grc_console_log("Error at path", path, "position", __current_path_pos);
					show_error("Missing expected data structure", true)
				}
				else return return_if_not_found;
			}
			
			var current_key = path[@ __current_path_pos];
			
			var expecting_array = is_real(current_key);
			var is_valid_key = expecting_array || is_string(current_key);
			if !is_valid_key {
				if throw_error_if_invalid {
					grc_console_log("Error at path", path, "position", __current_path_pos);
					show_error("Invalid subpath type: must be string or number", true)
				}
				else return return_if_not_found;
			}
			
			var is_compatible_data = expecting_array ? is_array(parent) : is_struct(parent);
			
			if !is_compatible_data {
				if throw_error_if_invalid {
					show_error(array_concat(["Found incompatible data structure for key in path", path, "at path position", __current_path_pos, parent]), true);
				}
				else return return_if_not_found;
			}
			
			var child = expecting_array ? array_get(parent,current_key) : struct_get(parent,current_key);
			var child_exists = !is_undefined(child);
				
			var is_final_key = __current_path_pos == array_length(path)-1 ;
			return is_final_key
				? (child_exists ? child : return_if_not_found)
				: get_path_value(child, path, return_if_not_found, throw_error_if_invalid, __current_path_pos+1 );
		}

		function exists(value) {
			return !is_equal(value, pointer_null) && !is_equal(value, undefined)
		}

		function is_equal(val1, val2) {
			if is_boolish(val1) && is_boolish(val2) {
				return (val1 == val2);
			}
			return (typeof(val1) == typeof(val2)) && (val1 == val2);
		}

		function is_boolish(value) {
			if is_bool(value) { return true; }
			if is_real(value) {
				return (value == 0 || value == 1);
			}
			return false;
		}

		function sort_by(array_of_structs, field_string_or_path_array, ascending=true) {
	
			if is_string(field_string_or_path_array) {
				field_string_or_path_array = string_to_path_array(field_string_or_path_array)
			}
			var sort_function = method({ field : field_string_or_path_array, ascending : ascending },
				function(struct0, struct1) {
					var val0 = get_path_value(struct0, field);
					var val1 = get_path_value(struct1, field);
					
					var equality_outcome = 0;
					if !exists(val0)		{ equality_outcome = -1; }
					else if !exists(val1)	{ equality_outcome = 1; }
					else if (typeof(val0) == typeof(val1)) && (is_string(val0) || is_real(val0)) {
						if is_string(val0) {
							val0 = string_lower(val0);
							val1 = string_lower(val1);
						}
						
						if (val0 == val1) {
							return 1;
						}
						
						equality_outcome = (val0 < val1) ? -1 : 1;
					}
					
					if !ascending {
						equality_outcome *= -1;
					}
					return equality_outcome;
				}
			)
			
			array_sort(array_of_structs, sort_function);
		}		
