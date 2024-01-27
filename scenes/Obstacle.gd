extends RigidBody2D
@export var sprite : Texture2D;
@export var hitbox : CollisionShape2D;

func _ready():
	set_freeze_enabled(true);
	$Sprite2D.texture = sprite;

func _process(delta):
	pass
