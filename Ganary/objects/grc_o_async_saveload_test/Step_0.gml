event_inherited()
if active{
	/// @description  Check for Save Game
	timeout += 1/room_speed;

	if timeout > timeout_max{
		if saving{
			grc_async_assert(true, false, "Saving took more than 3 seconds!");
		}
		else{
			grc_async_assert(true, false, "Loading took more than 3 seconds!");
		}
	}


	if (saving or loading) {	
		exit;
	}
	else{
		if next_action == asycn_saveload_next_action.save{
			show_debug_message("saving...");
			value = irandom_range(0, 255);
			expected_value = value;
			if os_get_config() == "GDK"
				gdk_save_group_begin()
			else
				buffer_async_group_begin("asyncsavegroup");
		    buffer_async_group_option("showdialog", 0);
		    buffer_async_group_option("savepadindex", 0);
		    buffer_async_group_option("saveslotsize", 1);   
		    buffer_async_group_option("slottitle", "savefordemo");
		    buffer_async_group_option("subtitle", "this is more info about the save");
		    if( os_type==os_psvita ){
		        // 0 = out of space, allow to continue without saving
		        // 1 = out of space, user must free up space to continue
		        buffer_async_group_option("vita_outofspace_msg",0);
		    }
    
		    savebuff = buffer_create(1, buffer_grow, 1);
		    ini_open_from_string("");
    
		    // write all your data here
		    ini_write_real("my_save_data", "value", value);
    
		    var inistring = ini_close();
    
		    buffer_write(savebuff, buffer_string, inistring);
			if os_get_config() == "GDK"
				gdk_save_buffer(savebuff, save_fn, 0, buffer_get_size(savebuff));
			else
				buffer_save_async(savebuff, save_fn, 0, buffer_get_size(savebuff));
		    saveid = os_get_config() == "GDK" ? gdk_save_group_end() : buffer_async_group_end();    
			grc_console_log("saveid:", saveid);
			grc_console_log(save_fn);
		    saving = true;
			next_action = asycn_saveload_next_action.load;
		}
		else if next_action == asycn_saveload_next_action.load{
			show_debug_message("loading...");    
		    loadbuff = buffer_create(1,buffer_grow,1);    
		    if os_get_config() == "GDK"
				gdk_save_group_begin("asyncsavegroup")
			else
				buffer_async_group_begin("asyncsavegroup");    // save folder 
		    buffer_async_group_option("showdialog",0);
		    buffer_async_group_option("savepadindex", 0);
		    buffer_async_group_option("slottitle","savefordemo");    // don't show any dialogues, load from slot 0     
			if os_get_config() == "GDK"{
				gdk_load_buffer(loadbuff,save_fn,0,-1);
			}
			else{
				buffer_load_async(loadbuff,save_fn,0,-1);   // Say what we want to load and into which buffer  
			}
 
		    loadid = os_get_config() == "GDK" ? gdk_save_group_end() : buffer_async_group_end();    // Actually start loading now please   
		    loading = true;
			grc_console_log("loadid:", loadid);
			grc_console_log(save_fn);
			next_action = asycn_saveload_next_action.evaluate
		}
		else if next_action == asycn_saveload_next_action.evaluate{
			grc_async_assert(value,expected_value);
			olympus_test_resolve();
			instance_destroy();
		}
	}
}