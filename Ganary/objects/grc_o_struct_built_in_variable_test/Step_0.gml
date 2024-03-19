// create new entries in the struct
show_debug_message( $"Creating {numToCreate} variables");
for( var n=0; n<numToCreate; ++n) {
	
	// generate a random name
	var r = random_range(0, 1_000_000);	
	var name;
	if (r & 0x1) {
		name = $"{chr( ord("a") + n%25 )}_{r}_{n}";
	} else {
		name = builtinNames[ n%array_length(builtinNames) ]		
	} // end else
	array_push( varsCreated, name );	
	vars[$ name ] = name;	
} // end for

show_debug_message( $"Deleting {numToDelete} variables" );
for( var n=0; n<numToDelete; ++n) {
	
	// choose a random name
	var r = random_range( 0, array_length(varsCreated) );
	var name = varsCreated[r];
	
	struct_remove( vars, name );
	array_delete( varsCreated, r, 1 );
}