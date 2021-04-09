/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
if active{
	show_debug_message("Frame " + string(frame) + ": " + json_stringify(struct));
	if (frame <= frame_number_to_assign_new_array) {
		if (frame == frame_number_to_assign_new_array) {
			var new_array = ["Assigned in step event!"];
			pass_array_to_struct_assignment_function(new_array);
		}
	}
	else {
		//Struct's held array should not be empty
		grc_async_assert(array_length(struct.held_array) > 0, true, "Struct's held array should not be empty");
	}
	
	if frame < frame_max{
		frame++;	
	}
	else{
		olympus_test_resolve();
		instance_destroy();
	}
}