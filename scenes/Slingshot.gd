extends Node2D

enum State {
	IDLE,
	PULLING,
	THROWN,
	RESET
}

var state : State = State.IDLE;

func _ready():
	print_debug(%SlingshotCenter.position);
	%LeftLine.points[1] = %SlingshotCenter.position;
	%RightLine.points[1] = %SlingshotCenter.position;


func _process(delta):
	var center : Vector2 = %SlingshotCenter.position;
	match state:
		State.IDLE:
			return;
		State.PULLING:
			if Input.is_action_pressed("LMouse"):
				var mouse_pos := get_global_mouse_position();
				if mouse_pos.distance_to(center) > 100:
					mouse_pos = center + (mouse_pos - center).normalized() * 100;
				%LeftLine.points[1] = mouse_pos;
				%RightLine.points[1] = mouse_pos;
			else:
				var location := get_global_mouse_position();
				var distance := location.distance_to(center);
				var velocity = center - location;
				var projectile : Projectile = get_tree().get_nodes_in_group("Projectile")[0];
				projectile.throw();
				projectile.apply_impulse(Vector2(), velocity / 50 * distance);
				state = State.THROWN;
				%LeftLine.points[1] = center;
				%RightLine.points[1] = center;
				
		State.THROWN:
			return;
		State.RESET:
			return;
	


func _on_touch_area_input_event(viewport, event, shape_idx):
	if state == State.IDLE:
		if (event is InputEventMouseButton && event.pressed):
			print_debug("input event");
			state = State.PULLING;
			
