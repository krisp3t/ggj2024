extends RigidBody2D
var direction : Direction = Direction.FORWARD;

enum Direction {
	FORWARD,
	LEFT,
	RIGHT
}

func _ready():
	set_freeze_enabled(true);
	$AnimatedSprite2D.play("forward");

func _process(delta):
	match direction:
		Direction.LEFT:
			print_debug(position);
			position.x -= 100 * delta;
		Direction.RIGHT:
			position.x += 100 * delta;

func _on_raycast_timer_timeout():
	var x : int = randi_range(-500, 500);
	var pos : Vector2 = Vector2(x, $RayCast2D.target_position.y);
	$RayCast2D.target_position = pos;
	$Line2D.points[1] = pos;

func _on_move_timer_timeout():
	var i := randi_range(0, 2);
	match i:
		0: 
			direction = Direction.FORWARD;
			$AnimatedSprite2D.play("forward");
		1:
			direction = Direction.LEFT;
			$AnimatedSprite2D.play("left");
		2:
			direction = Direction.RIGHT;
			$AnimatedSprite2D.play("right");
	
