extends Node2D
@onready var game_manager = get_node("/root/GameManager");
var is_projectile_loaded := true;
const SPEECH_END_POSITION := Vector2(1551, 24);
const SPEECH_START_POSITION := Vector2(1951, 24);
var classroom : Node2D;

func _ready():
	var classroom_scene_path = game_manager.get_level();
	var classroom_scene = load(classroom_scene_path);
	classroom = classroom_scene.instantiate();
	add_child(classroom);
	classroom.shot.connect(_on_slingshot_shot);
	game_manager.laugh_percentage = 50.0;
	_show_speech_bubble("Entertain the classroom!", 5);
	
func _process(delta):
	%EraserProgressBar.value = %EraserTimer.time_left / %EraserTimer.wait_time;
	%SpitballProgressBar.value = %SpitballTimer.time_left / %SpitballTimer.wait_time;
	game_manager.laugh_percentage -= 0.9 * delta;
	%LaughProgressBar.value = game_manager.laugh_percentage;
	if %LaughProgressBar.value <= 0:
		game_manager.current_game_state = game_manager.GameState.LOSS;
		%PopupTexture.visible = true;
	if %LaughProgressBar.value >= 100:
		game_manager.current_level += 1;
		get_tree().reload_current_scene();
	
func _on_eraser_timer_timeout():
	if !is_projectile_loaded:
		%EraserButton.disabled = false;

func _on_spitball_timer_timeout():
	if !is_projectile_loaded:
		%SpitballButton.disabled = false;
	
func _on_eraser_button_pressed():
	%EraserButton.disabled = true;
	%EraserTimer.start();
	var slingshot_center = get_node("Classroom/Slingshot/SlingshotCenter");
	var projectile : Projectile = game_manager.spawn_projectile(game_manager.ProjectileType.ERASER);
	projectile.global_position = slingshot_center.global_position + Vector2(0, -28);
	add_child(projectile);
	is_projectile_loaded = true;

func _on_spitball_button_pressed():
	%SpitballButton.disabled = true;
	%SpitballTimer.start();
	var slingshot_center = get_node("Classroom/Slingshot/SlingshotCenter");	
	var projectile : Projectile = game_manager.spawn_projectile(game_manager.ProjectileType.SPITBALL);
	projectile.global_position = slingshot_center.global_position + Vector2(0, -28);
	add_child(projectile);
	is_projectile_loaded = true;
	
func _on_slingshot_shot():
	is_projectile_loaded = false;
	if %EraserTimer.is_stopped():
		%EraserButton.disabled = false;
	if %SpitballTimer.is_stopped():
		%SpitballButton.disabled = false;

func _show_speech_bubble(text: String, time: float = 2.0):
	var tween := get_tree().create_tween()
	%SpeechText.text = text;
	tween.tween_property(%SpeechBubble, "position", SPEECH_END_POSITION, 0.5);
	tween.tween_property(%SpeechText, "visible", true, 0.01);
	tween.tween_interval(time);
	tween.tween_property(%SpeechText, "visible", false, 0.01);	
	tween.tween_property(%SpeechBubble, "position", SPEECH_START_POSITION, 0.45);

func _on_popup_button_pressed():
	get_tree().reload_current_scene();
