
function grc_register_compile_tests(){

	olympus_add_test("caused_compile_failure_pre_410", function(){
		globalvar ITEMS; ITEMS = ds_map_create();

		function drop_item(source_entity_struct) {
	
			var source_instance = source_entity_struct;
	
			var new_eid			= 123;
	
			with instance_create_depth(0,0,0, new_eid) {
				var location_found = false;
		
				var source_instance_exists = instance_exists(source_instance);
				var source_itemid = source_entity_struct.id;
		
				z = ITEMS[?source_itemid].height*.5 + source_instance_exists ? source_instance.z : 0;
				var drop_distance = (random_range(50,100)) + ITEMS[?source_itemid].hitbox_width*.5;
			
				while !location_found {
					var drop_direction	= random_range(135,405);
					var drop_target_x	= round(source_entity_struct.x+lengthdir_x(drop_distance, drop_direction));
					var drop_target_y	= round(source_entity_struct.y+lengthdir_y(drop_distance, drop_direction));
				}
			}
	
		}
	})
}
