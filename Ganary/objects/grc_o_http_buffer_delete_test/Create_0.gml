event_inherited();
receiving_buffer = buffer_create(1, buffer_grow, 1);
var header = ds_map_create();
var url = "https://google.com";
if (os_type == os_xboxseriesxs){
	url = "https://profile.xboxlive.com/users/me/profile/settings?settings=GameDisplayName";
}
http_request_handle = http_request(url, "GET", header, receiving_buffer);
