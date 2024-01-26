extends Node

enum GameState {
	START,
	PLAY,
	WIN,
	LOSS
}

var current_game_state := GameState.PLAY;

func _process(_delta) -> void:
	match current_game_state:
		GameState.START:
			pass;
		GameState.PLAY:
			pass;
		GameState.WIN:
			pass;
		GameState.LOSS:
			pass;

