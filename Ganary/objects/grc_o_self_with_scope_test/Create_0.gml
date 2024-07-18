/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
can_reach = false;

with grc_o_self_with_scope_test {
	can_reach = true;
	return;
}
can_reach = false;