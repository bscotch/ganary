event_inherited()
image_speed = 1;
skeleton_animation_set("fallfromspace", false);
call_later(10, time_source_units_seconds, function(){
	show_debug_message("Destroying the object for expiration!");
	olympus_test_reject();
	instance_destroy();
})