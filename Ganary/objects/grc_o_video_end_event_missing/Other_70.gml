/// @description Insert description here
// You can write your code in this editor
if async_load[? "type"] == "video_end"{
	olympus_test_resolve();
	instance_destroy();
}

if async_load[? "type"] == "video_start"{
	video_close();
}