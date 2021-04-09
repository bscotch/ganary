// Inherit the parent event
event_inherited();

if debug_mode{
	show_error("This test must be performed in non-debug mode", true);
}
working = true;
my_helper = instance_create_depth(0,0,0,grc_o_garbage_collection_test_helper);