extends Node2D
@onready var game_manager = get_node("/root/GameManager")
var is_projectile_loaded := true;

func _ready():
	%LaughProgressBar.value = 50.0;

func _process(delta):
	%EraserProgressBar.value = %EraserTimer.time_left / %EraserTimer.wait_time;
	%SpitballProgressBar.value = %SpitballTimer.time_left / %SpitballTimer.wait_time;
	%LaughProgressBar.value -= 0.9 * delta;
	if %LaughProgressBar.value <= 0:
		game_manager.current_game_state = game_manager.GameState.LOSS;
	
func _on_eraser_timer_timeout():
	if !is_projectile_loaded:
		%EraserButton.disabled = false;

func _on_spitball_timer_timeout():
	if !is_projectile_loaded:
		%SpitballButton.disabled = false;
	
func _on_eraser_button_pressed():
	%EraserButton.disabled = true;
	%EraserTimer.start();
	var projectile : Projectile = game_manager.spawn_projectile(game_manager.ProjectileType.ERASER);
	projectile.global_position = %Classroom/%Slingshot/%SlingshotCenter.global_position + Vector2(0, -28);
	add_child(projectile);
	is_projectile_loaded = true;

func _on_spitball_button_pressed():
	%SpitballButton.disabled = true;
	%SpitballTimer.start();
	var projectile : Projectile = game_manager.spawn_projectile(game_manager.ProjectileType.SPITBALL);
	projectile.global_position = %Classroom/%Slingshot/%SlingshotCenter.global_position + Vector2(0, -28);
	add_child(projectile);
	is_projectile_loaded = true;
	
func _on_slingshot_shot():
	is_projectile_loaded = false;
	if %EraserTimer.is_stopped():
		%EraserButton.disabled = false;
	if %SpitballTimer.is_stopped():
		%SpitballButton.disabled = false;	
	

