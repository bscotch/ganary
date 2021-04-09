/// @arg obj
/// @arg [x=0
/// @arg y=0
/// @arg depth=0]
function grc_instance_create() {
	var xx = 0;
	var yy = 0;
	var d = 0;
	if argument_count > 1{
		xx = argument[1];
	}
	if argument_count > 2{
		xx = argument[2];
	}
	if argument_count > 3{
		xx = argument[3];
	}
	return instance_create_depth(xx,yy,d, argument[0]);
}

/// @desc grc_cjk_insert_space()
/// @arg text
/// @arg width[
/// @arg scale]
function grc_cjk_insert_space() {
	// insert spaces for CJK strings according to width

	var text = argument[0];
	var width = argument[1];
	if width <= 0{
		width = display_get_gui_width();
	}
	var scale = 1;

	if argument_count > 2
		scale = argument[2];
	var scale = 1;
	if scale != 0
		width /= scale;

	var text_length = string_length(text);
	var char_width = 0;
	for (var i = 0; i < text_length; i++){
		var current_char = string_char_at(text,i);
		if current_char == " "{
			char_width[i] = 0;
		}
		else{
			var v_byte_length = string_byte_length(current_char);
			if v_byte_length > 1{
				char_width[i] = string_width("的");
			}
			else{
				char_width[i] = string_width(current_char);
				if char_width[i] <= 0 || is_undefined(char_width[i]){
					char_width[i] = string_width("的");
				}
			}
		}
		char_width[i] *= scale;
	}

	var char_counter = 0;
	var current_line_width = 0;
	for (var j = 0; j < text_length; j++){
		if char_width[char_counter] == 0{
			current_line_width = 0;
			char_counter++;
		}
		else{
			current_line_width += char_width[char_counter]
			if current_line_width < width{
				char_counter++;
			}
			else{
				text = string_insert(" ",text,j);
				current_line_width = 0;
				text_length++;
			}
		}
	}
	return text;
}

/// grc_console_log(item1 [,item2 [,..]])
/// @param item1
/// @param [item2...]
function grc_console_log() {
	var echo_item;
	var echo_string="";
	for(echo_item=0;echo_item<argument_count;echo_item++){
		echo_string+=string(argument[echo_item])+" ";
	}
	var final_string = echo_string;
	if debug_mode {
		final_string = string_replace_all(final_string, "%", "*");
	}
	show_debug_message(final_string)
}