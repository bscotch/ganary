/// @description Insert description here
// You can write your code in this editor
audio_debug(true);
audio_master_gain(0.1);

ts = call_later(2, time_source_units_frames, function() {
    var idx = audio_play_sound(grc_snd_wave2, 0, false);
    if (audio_exists(idx)) {
        audio_sound_set_track_position(idx, 0.1);
    }
}, true);