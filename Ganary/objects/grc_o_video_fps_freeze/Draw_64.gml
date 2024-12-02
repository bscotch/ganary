/// @description Insert description here
// You can write your code in this editor
var _data = video_draw();
var _status = _data[0];

if (_status == 0)
{
    var _surface = _data[1];
    draw_surface(_surface, x, y);
}

var video_position = string(floor(video_get_position() / 1000)) + "/" + string(floor(video_get_duration() / 1000));
draw_text(32, 704, "Video position: " + video_position);
show_debug_message(string(video_get_position()));