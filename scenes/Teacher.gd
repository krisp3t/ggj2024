extends RigidBody2D
var direction : Direction = Direction.FORWARD;
const RAYCAST_Y : int = 758;

enum Direction {
	FORWARD,
	LEFT,
	RIGHT
}

func _ready():
	set_freeze_enabled(true);
	$AnimatedSprite2D.play("forward");

			
func _physics_process(delta):
	match direction:
		Direction.LEFT:
			move_and_collide(Vector2(-100, 0) * delta);
		Direction.RIGHT:
			move_and_collide(Vector2(100, 0) * delta);
			
	if ($RayCast2D.is_colliding()):
		print_debug("collide raycast");

func _on_raycast_timer_timeout():
	var pos : Vector2;
	match direction:
		Direction.FORWARD:
			var x : int = randi_range(-500, 500);
			pos = Vector2(x, RAYCAST_Y);
		Direction.LEFT:
			pos = Vector2(-5000, $AnimatedSprite2D.position.y);
		Direction.RIGHT:
			pos = Vector2(5000, $AnimatedSprite2D.position.y);
	$RayCast2D.target_position = pos;
	$Line2D.points[1] = pos;

func _on_move_timer_timeout():
	var i := randi_range(0, 10);
	match i:
		0,1,2,3,4,5,6: 
			direction = Direction.FORWARD;
			$AnimatedSprite2D.play("forward");
		7,8:
			direction = Direction.LEFT;
			$AnimatedSprite2D.play("left");
		9,10:
			direction = Direction.RIGHT;
			$AnimatedSprite2D.play("right");
	
