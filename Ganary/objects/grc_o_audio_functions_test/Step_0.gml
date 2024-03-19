event_inherited()
if audio_group_is_loaded(my_audio_group){
	swap_timer ++;
	show_debug_message("Loaded");
	audio_play_sound(my_audio_resource,10,false);
	
	if (swap_timer < swap_timer_max){	
		loaded = false;
		var unload_success = audio_group_unload(my_audio_group);		
		grc_async_assert(true, unload_success, "Unloading should return true");
		show_debug_message("Unloaded");		
	}
	else{	
		olympus_test_resolve();
		instance_destroy();		
	}
}
else{
	audio_group_load(my_audio_group);
}