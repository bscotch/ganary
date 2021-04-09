var ident = async_load[? "id"];

show_debug_message(json_encode(async_load));

if (async_load[? "status"] == -1)
{
    if (async_load[? "error"] == 1001)
    {
        show_debug_message("user cancelled operation");
    }
    else if (async_load[? "error"] == 1002)
    {
        show_debug_message("slot contained corrupt data");
    }
    else if (async_load[? "error"] == 1003)
    {
        show_debug_message("out of space on device");
    }
    
    saving = false;
    loading = false;
    exit;
}

if (ident == saveid and saving)
{
    show_debug_message("save complete.");
    buffer_delete(savebuff);
    saving = false;
}
else if (ident == loadid and loading)
{
    show_debug_message("load complete.");
    var inistr = buffer_read(loadbuff, buffer_string);
    ini_open_from_string(inistr);
    
    value = ini_read_real("my_save_data", "value", 0);
    
    ini_close();
    buffer_delete(loadbuff);
    
    loading = false;
}

