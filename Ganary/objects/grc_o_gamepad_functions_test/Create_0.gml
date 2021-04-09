// Inherit the parent event
event_inherited();

timeout = 0;
timeout_max = 1;

buttons_to_test = ds_list_create();
ds_list_add(buttons_to_test,
gp_face1,
gp_face2,
gp_face3,
gp_face4,
gp_padu,
gp_padd,
gp_padl,
gp_padr,
gp_select,
gp_start,
gp_stickl,
gp_stickr,
gp_shoulderl,
gp_shoulderlb,
gp_shoulderr,
gp_shoulderrb,
)