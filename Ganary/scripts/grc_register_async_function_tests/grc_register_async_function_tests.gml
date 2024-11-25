function grc_register_async_function_tests(){
	if !debug_mode{
		olympus_add_async_test("garbage_collection_test", function(){
			return grc_instance_create(grc_o_garbage_collection_test);
		})
	}

	olympus_add_async_test("dynamic_texture_group_test", function(){
		var ins = grc_instance_create(grc_o_dynamic_texture_group_test);
		return ins;
	})

	olympus_add_async_test("http_header_test_short_body", function(){
	  //https://github.com/YoYoGames/GameMaker-Bugs/issues/6919
		var ins = grc_instance_create(grc_o_http_header_test);
		with ins {
			var s = "a"
			repeat 3052 {
				s += "a";
			}
			body = s		
		}
		return ins;
	})

	olympus_add_async_test("http_header_test_long_body", function(){
		var ins = grc_instance_create(grc_o_http_header_test);
		with ins {
			var s = "a"
			repeat 3054 {
				s += "a";
			}
			body = s		
		}
		return ins;
	})

	olympus_add_async_test("self_with_scope_test", function(){
		//https://github.com/YoYoGames/GameMaker-Bugs/issues/6765
		return grc_instance_create(grc_o_self_with_scope_test);
	})

	olympus_add_async_test("deleting_ds_map_pre_http_async", function(){
		//https://github.com/YoYoGames/GameMaker-Bugs/issues/4505
		var map_count = debug_event("ResourceCounts", true).mapCount;
		show_debug_message("Num ds_maps: " + string(map_count));
		http_get("https://www.bscotch.net/api/dummy/headers");
		var new_map_count = debug_event("ResourceCounts", true).mapCount;
		show_debug_message("Num ds_maps: " + string(new_map_count));
		var new_map_index = new_map_count-1
		ds_map_destroy(new_map_index);
		return grc_instance_create(grc_o_deleting_ds_map_pre_http_async);
	})

	olympus_add_async_test("dynamic_asset_audio_track_pos_test", function(){
		return grc_instance_create(grc_o_dynamic_asset_ogg_track_test);
	})
	
	olympus_add_async_test("audio_play_stop_test", function(){
		//https://github.com/YoYoGames/GameMaker-Bugs/issues/7200
		return grc_instance_create(grc_o_audio_play_stop);
	}, function(){}, {olympus_test_options_timeout_millis: 1000 * 300})
	
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
	
	olympus_add_async_test("spine_async_event_test", function(){
		return grc_instance_create(grc_o_spine_async_event_test);
	}, function(){},
	{
		olympus_test_options_timeout_millis: 5000
	})
	
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

	//olympus_add_async_test("go_to_instance_exists_over_room_restart_test", function(){		
	//	room_goto(rm_grc_o_instance_exists_over_room_restart_test);
	//	return olympus_spawn_object_creation_awaiter(grc_o_instance_exists_over_room_restart_test);
	//})
	
	//olympus_add_async_test("instance_exists_over_room_restart_test", function(){		
	//	return instance_find(grc_o_instance_exists_over_room_restart_test, 0);
	//})
	
	olympus_add_async_test("keyboard_function_test", function(){
		return grc_instance_create(grc_o_keyboard_functions_test);
	})
	
	olympus_add_async_test("array_reference_test", function(){
		return grc_instance_create(grc_o_array_reference_test);
	})
	
	olympus_add_async_test("video_function_test_headless", function(){
		video_open("Ganary/cutscenes/grc.mp4");
		grc_expect_eq(video_format_rgba, video_get_format(), "The format should be rgba");
		grc_expect_eq(false, video_is_looping(), "the video should not be looping.");		
		return grc_instance_create(grc_o_video_function_test);
	});	
	
	olympus_add_async_test("video_end_event_missing", function(){
		return grc_instance_create(grc_o_video_end_event_missing);
	});
	
	olympus_add_async_test("video_open_block", function(){
		return grc_instance_create(grc_o_video_open_block);
	});

	olympus_add_async_test("global_function_definition_test", function(){
		return grc_instance_create(grc_o_global_function_definition_test);
	})
	
	xolympus_add_async_test("global_anon_function_leak_test", function(){
		return grc_instance_create(grc_o_anon_function_leak);
	}, function(){}, {olympus_test_options_timeout_millis: 1000 * 300})
}