extends Node
var projectile_scene := preload("res://scenes/Projectile.tscn")
var current_level := 1;
var classroom_scene : PackedScene;

enum GameState {
	START,
	PLAY,
	WIN,
	LOSS
}

enum ProjectileType {
	ERASER,
	SPITBALL
}

var current_game_state := GameState.PLAY;
var laugh_percentage := 50.0;

func get_level() -> String:
	match current_level:
		1: return "res://levels/Classroom1.tscn";
		2: return "res://levels/Classroom2.tscn";
		_: return "";

func _process(_delta) -> void:
	match current_game_state:
		GameState.START:
			pass;
		GameState.PLAY:
			pass;
		GameState.WIN:
			pass;				
		GameState.LOSS:
			current_game_state = GameState.START;

func spawn_projectile(type : ProjectileType) -> Projectile:
	var texture : String;
	match type:
		ProjectileType.ERASER:
			texture = "res://assets/sprites/png/eraser.png";
		ProjectileType.SPITBALL:
			texture = "res://assets/sprites/png/spitball.png";
	var projectile := projectile_scene.instantiate();
	projectile.texture_path = texture;
	return projectile
	
func _input(event) -> void:
	if Input.is_action_pressed("ESC"):
		get_tree().quit();
	
