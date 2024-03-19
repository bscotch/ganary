if skeleton_animation_is_finished(0) {
	animation_slot = (animation_slot + 1) mod (array_length(animation_sequence));
	skeleton_animation_set(animation_sequence[animation_slot], false);
}