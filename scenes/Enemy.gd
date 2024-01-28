extends RigidBody2D
class_name Enemy

@export var sprite : SpriteFrames;
@export var laugh_value : int;
@onready var game_manager = get_node("/root/GameManager");

func _ready():
	set_freeze_enabled(true);
	$AnimatedSprite2D.sprite_frames = sprite;
	$AnimatedSprite2D.play();
	


func _process(delta):
	pass


		
