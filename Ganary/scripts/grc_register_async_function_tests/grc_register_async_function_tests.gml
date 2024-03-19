function grc_register_async_function_tests(){
	if !debug_mode{
		olympus_add_async_test("garbage_collection_test", function(){
			return grc_instance_create(grc_o_garbage_collection_test);
		})
	}

	if (os_type == os_android && os_get_config() == "google"){
		olympus_add_async_test("dynamic_asset_audio_track_pos_test", function(){
			return grc_instance_create(grc_o_dynamic_asset_ogg_track_test);
		})
	}

	//os_xboxseriesxs requires XSTS token to talk to the bscotch dummy endpoint	
	if grc_internet_required {
		olympus_add_async_test("http_delete_receiver_test", function(){
			return grc_instance_create(grc_o_http_buffer_delete_test);
		})
		
		olympus_add_async_test("http_request_buffer_body_test", function(){
			return grc_instance_create(grc_o_http_request_buffer_body_test);
		}, function(){}, {olympus_test_options_timeout_millis: 1000 * 300})
	}
	
	olympus_add_async_test("spine_draw_in_struct_test", function(){
		return grc_instance_create(grc_o_spine_draw_in_struct_test);
	}, function(){})	
	
	olympus_add_async_test("struct_built_in_variable_test", function(){
		return grc_instance_create(grc_o_struct_built_in_variable_test);
	}, function(){})
	
	olympus_add_async_test("spine_low_fps_test", function(){
		return grc_instance_create(grc_o_spine_test);
	}, function(){},
	{
		olympus_test_options_timeout_millis: 30000
	})

	olympus_add_async_test("struct_varialbe_leak_test", function(){
		return grc_instance_create(grc_o_struct_varialbe_leak_tester);
	})

	olympus_add_async_test("camera_view_test", function(){
		return grc_instance_create(grc_o_camera_test);
	})

	olympus_add_async_test("async_saveload_test", function(){
		return grc_instance_create(grc_o_async_saveload_test);
	})
	
	olympus_add_async_test("room_functions_test", function(){
		return grc_instance_create(grc_o_room_functions_test);
	})

	olympus_add_async_test("go_to_instance_exists_over_room_restart_test", function(){		
		room_goto(rm_grc_o_instance_exists_over_room_restart_test);
		return olympus_spawn_object_creation_awaiter(grc_o_instance_exists_over_room_restart_test);
	})
	
	olympus_add_async_test("instance_exists_over_room_restart_test", function(){		
		return instance_find(grc_o_instance_exists_over_room_restart_test, 0);
	})
	
	olympus_add_async_test("keyboard_function_test", function(){
		return grc_instance_create(grc_o_keyboard_functions_test);
	})
	
	olympus_add_async_test("array_reference_test", function(){
		return grc_instance_create(grc_o_array_reference_test);
	})
	
	olympus_add_async_test("video_function_test_headless", function(){
		video_open("cutscenes/grc.mp4");
		grc_expect_eq(video_get_duration(), 1000, "The included video should be 1000 ms long.");
		grc_expect_eq(video_get_format(), video_format_rgba, "The format should be rgba");
		grc_expect_eq(video_is_looping(), false, "the video should not be looping.");		
		return grc_instance_create(grc_o_video_function_test);
	});		
}