event_inherited()
/*
EXPLANATION:

This project shows how spine animations break at certain frame rates, because skeleton_animation_is_finished() won't properly return 'true' sometimes.
It shows a player character that moves through 3 animations: "idle", "run_transition", and "run".
It starts at 30 fps, and pressing "up" or "down" will change the frame rate.

The animation sequence properly plays through at 25 fps and above, and at 10-11 fps.
When fps is at 12-24, the second animation ("run_transition") plays, but skeleton_animation_is_finished() doesn't return 'true', so we can't progress to the next frame.

*/
original_fps = game_get_speed(gamespeed_fps);
draw_function = draw_self;
spinte_test_fps = 30;
game_set_speed(spinte_test_fps, gamespeed_fps);

animation_sequence = ["idle", "run_transition", "run"];
animation_slot = 0;
skeleton_animation_set(animation_sequence[animation_slot], false);
method_tested = "draw_self";


recursive_test_function = function(_fps){
	show_debug_message("FPS: " + string(spinte_test_fps));
	show_debug_message(string(animation_slot));
	grc_async_assert(0,animation_slot, "Testing " + method_tested + " for FPS " + string(spinte_test_fps));
	spinte_test_fps = _fps;
	game_set_speed(spinte_test_fps, gamespeed_fps);
	animation_slot = 0;
	skeleton_animation_set(animation_sequence[animation_slot], false);
}


call_later(spinte_test_fps*3, time_source_units_frames, function(){
	recursive_test_function(20);	
	
	call_later(spinte_test_fps*3, time_source_units_frames, function(){
		recursive_test_function(60);

		call_later(spinte_test_fps*3, time_source_units_frames, function(){
			draw_function = draw_sprite_ext;
			method_tested = "draw_sprite_ext";
			recursive_test_function(30);
			
			call_later(spinte_test_fps*3, time_source_units_frames, function(){
				show_debug_message("Testing draw_sprite_ext");
				recursive_test_function(20);
	
	
				call_later(spinte_test_fps*3, time_source_units_frames, function(){
					recursive_test_function(60);
					call_later(spinte_test_fps*3, time_source_units_frames, function(){
						show_debug_message("FPS: " + string(spinte_test_fps));
						show_debug_message(string(animation_slot));
						grc_async_assert(0,animation_slot);
						olympus_test_resolve();
						game_set_speed(original_fps, gamespeed_fps);
						instance_destroy();
					})
				})
			})			
		})
	})
})