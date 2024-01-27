extends RigidBody2D
class_name Projectile;
@export var texture_path : String = "res://assets/sprites/png/spitball.png";

func _ready():
	set_freeze_enabled(true);
	$Sprite2D.texture = load(texture_path);

func _process(delta):
	pass

func throw():
	set_freeze_enabled(false);
	remove_from_group("SelectedProjectile");
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free();
