extends RigidBody2D
@export var sprite : SpriteFrames;
@export var laugh_value : int

func _ready():
	set_freeze_enabled(true);
	$AnimatedSprite2D.sprite_frames = sprite;
	$AnimatedSprite2D.play();

func _process(delta):
	pass
