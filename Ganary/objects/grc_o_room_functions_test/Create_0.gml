// Inherit the parent event
event_inherited();
starting_room_width = room_width;
starting_room_height = room_height;
current_room = room;
temp_room = room_add();
room_restart_counter = 0;
room_restart_counter_max = 5;