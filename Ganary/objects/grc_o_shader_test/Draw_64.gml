/// @description Insert description here
// You can write your code in this editor
if flash > 0 {
    shader_set(grc_shad_flash);
    shader_set_uniform_f(flashpass,flash);
}

var screen_mid_x = display_get_gui_width()/2;
var screen_mid_y = display_get_gui_height()/2;

draw_sprite_ext(sprite_index,0,screen_mid_x,screen_mid_y,1,1,0,c_white,1);
shader_reset();
var seconds_since_update = min(.05,delta_time/1000000);
flash = max(0,flash-5*seconds_since_update);


