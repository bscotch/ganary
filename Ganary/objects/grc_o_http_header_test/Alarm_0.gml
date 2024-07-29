/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
var map = ds_map_create();
map[?"Content-Type"] = "text/html; charset=utf-8"
req = http_request("https://beta.bscotch.net/api/dummy/echo?header=true", "POST", map, body);
encoded = base64_encode(body);
grc_console_log("Testing header length of", string_length(encoded));
ds_map_destroy(map);