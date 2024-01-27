extends Node2D

enum State {
	IDLE,
	PULLING,
	THROWN,
	RESET
}

signal shot;

var state : State = State.IDLE;

func _ready():
	%LeftLine.points[1] = %SlingshotCenter.position;
	%RightLine.points[1] = %SlingshotCenter.position;


func _process(delta):
	var center : Vector2 = %SlingshotCenter.position;
	match state:
		State.IDLE:
			return;
		State.PULLING:
			if Input.is_action_pressed("LMouse"):
				var mouse_pos := get_local_mouse_position();
				if mouse_pos.distance_to(center) > 150:
					mouse_pos = center + (mouse_pos - center).normalized() * 150;
				%LeftLine.points[1] = mouse_pos;
				%RightLine.points[1] = mouse_pos;
			else:
				var location_vec := get_local_mouse_position();
				var distance := location_vec.distance_to(center);
				var velocity_vec = center - location_vec;
				var projectile : RigidBody2D = get_tree().get_nodes_in_group("Projectile")[0];
				projectile.throw();
				projectile.apply_impulse(velocity_vec / 100 * distance);
				%LeftLine.points[1] = center;
				%RightLine.points[1] = center;
				shot.emit();
				state = State.THROWN;
		State.THROWN:
			state = State.IDLE;
			return;
		State.RESET:
			return;
	


func _on_touch_area_input_event(viewport, event, shape_idx):
	if state == State.IDLE:
		if (event is InputEventMouseButton && event.pressed):
			state = State.PULLING;
			
