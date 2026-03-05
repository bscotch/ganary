/// @description Insert description here
// You can write your code in this editor
var status = texturegroup_get_status("texgroup1");
//https://github.com/YoYoGames/GameMaker-Bugs/issues/14236
var expected = texturegroup_status_fetched;
if GM_runtime_type == "gmrt"{
	expected = texturegroup_status_loaded;
}

if (status == expected){
	grc_console_log("texgroup1 loading completed");
	olympus_test_resolve();
	instance_destroy();
}
else{
	alarm[1] = 5;
}