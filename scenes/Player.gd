extends RigidBody2D

func _ready():
	set_freeze_enabled(true);
	$AnimatedSprite2D.play();

func _process(delta):
	pass
