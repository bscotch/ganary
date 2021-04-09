/// @desc Render UI
draw_set_font(grc_fnt_ui);
draw_set_color(c_white);
draw_set_halign(fa_middle);
draw_set_valign(fa_center);
var screen_mid_x = display_get_gui_width()/2;
var screen_mid_y = display_get_gui_height()/2;
var scale = 1;
var button_name = "A";
if (os_type == os_switch){
	button_name = "B"
}

draw_text_ext_transformed(screen_mid_x, screen_mid_y,  @"Tests starts in:
" + string(ceil(_count_down_timer)) + @"

To start fresh:
Click anywhere or Press Gamepad " + button_name + " Button", 70, room_width * .8, scale, scale, 0);