/// @description Insert description here
// You can write your code in this editor
var pos = audio_sound_get_track_position(snd_2_id);
if pos > 0 {
	grc_console_log("pos:", pos);
	olympus_test_resolve();
}
else{
	olympus_test_reject("After 5 frames, the audio position should not be 0");
}