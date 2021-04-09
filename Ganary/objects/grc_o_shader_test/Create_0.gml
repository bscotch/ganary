/// @description Insert description here
// You can write your code in this editor
event_inherited();
flash = 0;
flashpass = shader_get_uniform(grc_shad_flash,"flash_amt");
click_count = 0;
click_count_max = 5;

self_click_timer = 0;
self_click_timer_max = .5;
