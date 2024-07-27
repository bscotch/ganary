/// @description Insert description here
// You can write your code in this editor
if (ds_map_find_value(async_load, "id") == req)
{
    if (ds_map_find_value(async_load, "status") == 0)
    {
        var res_map = ds_map_find_value(async_load, "response_headers");
		var actual_encoded = ds_map_find_value(res_map, "x-rumpus-dummy-body");
		var matched = string_count(actual_encoded, encoded);
		grc_async_assert(encoded, actual_encoded, "The request body should be returned as a base64 encoded string");
		olympus_test_resolve();
        instance_destroy();
    }
}