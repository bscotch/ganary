/// @description Insert description here
// You can write your code in this editor
var e_type = async_load[?"type"];
if (e_type == "audiogroup_load"){
	snd_1_id = audio_play_sound(grc_snd_silence_for_dynamic_asset, 1, false);
	var pos = audio_sound_get_track_position(snd_1_id);
	audio_stop_sound(snd_1_id);
	snd_2_id =  audio_play_sound(grc_snd_silence_for_dynamic_asset2, 50, false);
	audio_sound_gain(snd_2_id, 50, 0);
	alarm[0] = 5;
}









