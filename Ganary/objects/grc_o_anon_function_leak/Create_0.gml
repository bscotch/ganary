/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
function anon_const() constructor {
	show_debug_message(string(random(100)));
}

anon_assignment = function(){
	var s = {};
	for (var i = 0; i < 1000000; i ++){
		variable_struct_set(s, "key"+string(i), new anon_const());
	};
	//delete s;
	gc_collect();
	alarm[0] = 1
}
