// Inherit the parent event
event_inherited();

keyboard_string = grc_keyboard_string_test_expected;
grc_async_assert(keyboard_string,grc_keyboard_string_test_expected);