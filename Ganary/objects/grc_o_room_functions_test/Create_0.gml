// Inherit the parent event
event_inherited();
starting_room_width = room_width;
starting_room_height = room_height;
current_room = room;
temp_room = room_add();
room_restart_counter = 0;
room_restart_counter_max = 5;
_olympus_console_log("temp_room:", temp_room);
_olympus_console_log("current_room:", current_room);
_olympus_console_log("room:", room);
_olympus_console_log("Starting room functions test with initial room dimensions: " + string(room_width) + "x" + string(room_height));
