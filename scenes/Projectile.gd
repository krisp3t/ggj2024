extends RigidBody2D
class_name Projectile;
@export var texture_path : String = "res://assets/sprites/png/spitball.png";

func _ready():
	set_freeze_enabled(true);
	collision_layer = 0b1;
	$Sprite2D.texture = load(texture_path);

func _process(delta):
	pass

func throw():
	set_freeze_enabled(false);
	collision_layer = 0b00000000_00000000_00000000_10000001;
	remove_from_group("SelectedProjectile");
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free();
