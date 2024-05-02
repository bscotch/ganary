/// @description Insert description here
// You can write your code in this editor
call_cancel(reset_count);
time_source_destroy(exiting_call);
if should_turn_on_debug_overlay{
	show_debug_overlay(true);
}

instance_destroy(grc_o_controller);