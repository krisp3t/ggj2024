extends RigidBody2D
@export var sprite : SpriteFrames;
@export var laugh_value : int

func _ready():
	set_freeze_enabled(true);
<<<<<<< HEAD
	
=======
>>>>>>> 30ed24773fe84d516a86f17fcaed899c65f1cd7c
	$AnimatedSprite2D.sprite_frames = sprite;
	$AnimatedSprite2D.play();

func _process(delta):
	pass
