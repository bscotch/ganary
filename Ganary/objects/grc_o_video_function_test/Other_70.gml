/// @description Insert description here
// You can write your code in this editor
if async_load[? "type"] == "video_end"{
	olympus_test_resolve();
	instance_destroy();
}

if async_load[? "type"] == "video_start"{
	var current_position = video_get_position();
	show_debug_message(current_position);
}