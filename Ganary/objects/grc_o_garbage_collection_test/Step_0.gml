/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
if active{
	if !instance_exists(my_helper){
		show_debug_message("Did not crash");
		olympus_test_resolve();
		instance_destroy();
	}
}