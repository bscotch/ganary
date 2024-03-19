// https://github.com/YoYoGames/GameMaker-Bugs/issues/4851
event_inherited();
alarm[0] = 3;
restarted = false;
first_comp = -1;
second_comp = -1;
storedInstance = -1;
with grc_o_helper_blank
	other.storedInstance = self

