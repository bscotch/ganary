event_inherited()
num_entries = 10000;
struct = {};
iterations = 0;
time_to_add_keys_initial = 0;
time_to_add_keys_final = 0;

_char_is_numeric = function(_char) {
	var _char_code = ord(_char);
	return (_char_code >= 48 && _char_code <= 57);
}

_generate_consonumeric_string = function(_length, _must_start_with_letter=false) {
	var valid_chars = "0123456789bcdfghjklmnpqrstvwxz";
	var num_valid_chars = string_length(valid_chars);
	var the_string = "";
	
	while string_length(the_string) < _length {
		var _next_character = string_char_at(valid_chars, irandom(num_valid_chars));
		
		if _must_start_with_letter {
			if (string_length(the_string) == 0) {
				if _char_is_numeric(_next_character) {
					continue;
				}
			}
		}
		
		the_string += _next_character;
	}
	
	return the_string;	
}
