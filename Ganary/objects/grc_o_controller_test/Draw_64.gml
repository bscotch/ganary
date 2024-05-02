/// @description Insert description here
// You can write your code in this editor
draw_set_font(grc_fnt_cjk)
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
var draw_x = display_get_gui_width();
var draw_y = display_get_gui_height();
draw_set_color(c_green);
draw_text(draw_x, draw_y, "Automatically exiting in: " + string(time_source_get_time_remaining(exiting_call)));
draw_y -= 30;
draw_text(draw_x, draw_y, "Press face_1 or tap/click anywhere 5 times in quick succession to exit the test.");
draw_y -= 30;
draw_text(draw_x, draw_y, "Exit click count:" + string(click_count));
draw_y -= 30;
draw_text(draw_x, draw_y, "Try connect and disconnecting controllers!");
draw_y -= 30;