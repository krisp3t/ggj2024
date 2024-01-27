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
			position.x -= 10 * delta;
		Direction.RIGHT:
			position.x += 10 * delta;

func _on_raycast_timer_timeout():
	var x : int = randi_range(-500, 500);
	var pos : Vector2 = Vector2(x, $RayCast2D.target_position.y);
	$RayCast2D.target_position = pos;
	$Line2D.points[1] = pos;

func _on_move_timer_timeout():
	var i := randi_range(0, 2);
	var d : Direction;
	match i:
		0: 
			d = Direction.FORWARD;
			$AnimatedSprite2D.play("forward");
		1:
			d = Direction.LEFT;
			$AnimatedSprite2D.play("left");
		2:
			d = Direction.RIGHT;
			$AnimatedSprite2D.play("right");
	
