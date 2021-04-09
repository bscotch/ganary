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
	
			room_restart_counter ++;
			grc_async_assert(room_height,random_height);
			grc_async_assert(room_width, random_width);
			room_restart()	
		}
		else{
			grc_async_assert(room_restart_counter, room_restart_counter_max);
			olympus_test_resolve();
			room_height = starting_room_height;
			room_width = starting_room_width;
			instance_destroy();
		}
	}
	else{
		room_goto(temp_room);
	}
}