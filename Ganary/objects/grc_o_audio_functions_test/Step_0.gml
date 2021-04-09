event_inherited()
if active{
	var ag_d = a_group_test;

	repeat 5{		
		if audio_group_is_loaded(ag_d){
			show_debug_message("Unloaded")
			audio_group_unload(ag_d);
		}
		else{
			show_debug_message("Loaded")
			audio_group_load(ag_d);
		}
	}

	timeout += 1/room_speed;
	if timeout > timeout_max{
		olympus_test_resolve();
		instance_destroy();
	}
}