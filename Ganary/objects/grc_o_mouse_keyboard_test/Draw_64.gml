var key_pressed = keyboard_check_pressed(vk_anykey)
var key_press_or_release = keyboard_check(vk_anykey)
var key_release = keyboard_check_released(vk_anykey)

var current_key = "None";
if key_pressed || key_press_or_release || key_release{
	current_key = keyboard_lastkey;
}

var mx = round(device_mouse_x_to_gui(0));
var my = round(device_mouse_y_to_gui(0));

var last_mouse = "None";
if device_mouse_check_button(0, mb_left){
	last_mouse = "Left";
}
else if device_mouse_check_button(0, mb_right){
	last_mouse = "Right";
}
else if device_mouse_check_button(0, mb_middle){
	last_mouse = "Middle";
}
else if device_mouse_check_button(0, mb_any){
	last_mouse = "Any"
}

if device_mouse_check_button(0, mb_any){
	cursor_last_click_x = string(mx);
	cursor_last_click_y = string(my);
}


var mouse_moved = false;
if (mx != test_CURSOR_LAST_X || my != test_CURSOR_LAST_Y) {
	if ((abs(mx-test_CURSOR_LAST_X) >= 2) || (abs(my-test_CURSOR_LAST_Y) >= 2)){
		mouse_moved = true;
		test_CURSOR_LAST_X = mx;
		test_CURSOR_LAST_Y = my;
	}
}

current_key = string(current_key);
last_mouse = string(last_mouse);
my = string(my);
mx = string(mx);
mouse_moved = string(mouse_moved);
draw_set_font(grc_fnt_cjk)

draw_set_color(c_white);
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
var radius = 40;
var draw_x = display_get_gui_width()/2 - radius;
var draw_y = display_get_gui_height()/2;

draw_text(draw_x, draw_y, "current_key: " + current_key);
draw_y -= 30;
draw_text(draw_x, draw_y, "last_mouse: " + last_mouse);
draw_y -= 30;
draw_text(draw_x, draw_y, "Mouse moved: " + mouse_moved);
draw_y -= 30;
draw_text(draw_x, draw_y, "X: " + mx);
draw_y -= 30;
draw_text(draw_x, draw_y, "Y: " + my);
draw_y -= 30;
draw_text(draw_x, draw_y, "Last click X: " + cursor_last_click_x);
draw_y -= 30;
draw_text(draw_x, draw_y, "Last click Y: " + cursor_last_click_y);
draw_y -= 30;

var draw_x = display_get_gui_width() - radius;
var draw_y = display_get_gui_height();
draw_set_color(c_green);
draw_text(draw_x, draw_y, "Automatically exiting in: " + string(time_source_get_time_remaining(exiting_call)));
draw_y -= 30;
draw_text(draw_x, draw_y, "Click 5 times in quick succession to exit the test.");
draw_y -= 30;
draw_text(draw_x, draw_y, "Exit click count:" + string(click_count));
draw_y -= 30;


var draw_x = display_get_gui_width();
var draw_y = display_get_gui_height();

draw_set_color(c_red);
draw_circle(0,0,radius,false);
draw_circle(draw_x,0,radius,false);
draw_circle(draw_x,draw_y,radius,false);
draw_circle(0,draw_y,radius,false);