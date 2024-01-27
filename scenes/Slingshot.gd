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
			var location_vec := get_local_mouse_position();
			if location_vec.distance_to(center) > 150:
				location_vec = center + (location_vec - center).normalized() * 150;
			if Input.is_action_pressed("LMouse"):
				%LeftLine.points[1] = location_vec;
				%RightLine.points[1] = location_vec;
			else:
				var distance := location_vec.distance_to(center);
				var velocity_vec = center - location_vec;
				if len(get_tree().get_nodes_in_group("SelectedProjectile")) > 0:
					var projectile : RigidBody2D = get_tree().get_nodes_in_group("SelectedProjectile")[0];
					projectile.throw();
					projectile.apply_impulse(velocity_vec / 10 * distance);
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
			
