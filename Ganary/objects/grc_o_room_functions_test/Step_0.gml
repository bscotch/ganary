// Inherit the parent event
event_inherited();
if active{
	if current_room != room {
		if room_restart_counter < room_restart_counter_max{
			var random_height = irandom(1000);
			var random_width = irandom(2000);

			room_height = random_height;
			room_width = random_width;

			//room_set_height(room, random_height);
			//room_set_width(room, random_width);
	
			_olympus_console_log("Restarting room with dimensions: " + string(room_width) + "x" + string(room_height));

			room_restart_counter ++;
			grc_async_assert(room_height,random_height);
			grc_async_assert(room_width, random_width);
			room_restart()	
		}
		else{
			_olympus_console_log("Max room restarts reached, proceeding with test assertions.");
			grc_async_assert(room_restart_counter, room_restart_counter_max);
			olympus_test_resolve();
			room_height = starting_room_height;
			room_width = starting_room_width;
			instance_destroy();
		}
	}
	else{
		_olympus_console_log("Going to temporary room: " + string(temp_room));
		room_goto(temp_room);
	}
}