/// @description Insert description here
// You can write your code in this editor

var offset = 350;
var ydraw = 0;
var xdraw  = offset * mPadId;

if mPadId > 6{
	ydraw = 750
	xdraw = offset * (mPadId - 7)
}

var yoffset = 24;
draw_set_colour(mColour);
draw_set_font(grc_fnt_cjk);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(xdraw, ydraw, "face1: " + string(gamepad_button_check(mPadId, gp_face1))); ydraw+= yoffset
draw_text(xdraw, ydraw,  "face2: " + string(gamepad_button_check(mPadId, gp_face2))); ydraw+= yoffset
draw_text(xdraw, ydraw,  "face3: " + string(gamepad_button_check(mPadId, gp_face3))); ydraw+= yoffset
draw_text(xdraw, ydraw,  "face4: " + string(gamepad_button_check(mPadId, gp_face4))); ydraw+= yoffset
						
draw_text(xdraw, ydraw,  "up: " + string(gamepad_button_check(mPadId, gp_padu))); ydraw+= yoffset
draw_text(xdraw, ydraw,  "down: " + string(gamepad_button_check(mPadId, gp_padd))); ydraw+= yoffset
draw_text(xdraw, ydraw,  "left: " + string(gamepad_button_check(mPadId, gp_padl))); ydraw+= yoffset
draw_text(xdraw, ydraw,  "right: " + string(gamepad_button_check(mPadId, gp_padr))); ydraw+= yoffset
						   
draw_text(xdraw, ydraw,  "select: " + string(gamepad_button_check(mPadId, gp_select))); ydraw+= yoffset
draw_text(xdraw, ydraw,  "start: " + string(gamepad_button_check(mPadId, gp_start))); ydraw+= yoffset
draw_text(xdraw, ydraw,  "stickl: " + string(gamepad_button_check(mPadId, gp_stickl))); ydraw+= yoffset
draw_text(xdraw, ydraw,  "stickr: " + string(gamepad_button_check(mPadId, gp_stickr))); ydraw+= yoffset
					 
draw_text(xdraw, ydraw,  "shoulderL: " + string(gamepad_button_check(mPadId, gp_shoulderl))); ydraw+= yoffset
draw_text(xdraw, ydraw,  "shoulderR: " + string(gamepad_button_check(mPadId, gp_shoulderr))); ydraw+= yoffset
draw_text(xdraw, ydraw,  "shoulderLB: " + string(gamepad_button_check(mPadId, gp_shoulderlb))); ydraw+= yoffset
draw_text(xdraw, ydraw,  "shoulderRB: " + string(gamepad_button_check(mPadId, gp_shoulderrb))); ydraw+= yoffset

draw_text(xdraw, ydraw, "LStick X: " + string(gamepad_axis_value(mPadId, gp_axislh))); ydraw+= yoffset
draw_text(xdraw, ydraw, "LStick Y: " + string(gamepad_axis_value(mPadId, gp_axislv))); ydraw+= yoffset
draw_text(xdraw, ydraw, "RStick X: " + string(gamepad_axis_value(mPadId, gp_axisrh))); ydraw+= yoffset
draw_text(xdraw, ydraw, "RStick Y: " + string(gamepad_axis_value(mPadId, gp_axisrv))); ydraw+= yoffset

draw_text(xdraw, ydraw, "Controller: " + string(mPadId)); ydraw+= yoffset
draw_text(xdraw, ydraw, gamepad_get_description(mPadId)); ydraw+= yoffset
var guid = string_insert(" ",gamepad_get_guid(mPadId),15);
draw_text_ext(xdraw, ydraw, guid,yoffset,offset); ydraw+= yoffset*2
draw_text(xdraw, ydraw, "Connection:"+string(gamepad_is_connected(mPadId))); ydraw+= yoffset
if (switch_controller_joycon_dual == mType) {
	if (false == mJoyCons[0]) draw_text(xdraw, ydraw, "Joy-Con " + string(mPadId) + " has no connection to Left Joy-Con.");
	if (false == mJoyCons[1]) draw_text(xdraw, ydraw, "Joy-Con " + string(mPadId) + " has no connection to Right Joy-Con.");
}
