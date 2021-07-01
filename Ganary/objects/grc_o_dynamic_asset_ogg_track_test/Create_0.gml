/// @description Insert description here
// You can write your code in this editor

var snd_1_id = audio_play_sound(grc_snd_silence_for_dynamic_asset, 1, false);
var pos = audio_sound_get_track_position(snd_1_id);
audio_stop_sound(snd_1_id);
var snd_2_id =  audio_play_sound(grc_snd_silence_for_dynamic_asset2, 50, false);
audio_sound_gain(snd_2_id, 50, 0);
alarm[0] = 5;