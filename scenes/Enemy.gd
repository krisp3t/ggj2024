extends RigidBody2D
@export var sprite : SpriteFrames;

func _ready():
	set_freeze_enabled(true);
	$AnimatedSprite2D.play();
	$AnimatedSprite2D.sprite_frames = sprite;

func _process(delta):
	pass
