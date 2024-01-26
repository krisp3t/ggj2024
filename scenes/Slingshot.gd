extends Node2D

enum State {
	IDLE,
	PULLING,
	THROWN,
	RESET
}

var state : State = State.IDLE;

func _ready():
	%LeftLine.points[1] = %SlingshotCenter;
	%RightLine.points[1] = %SlingshotCenter;


func _process(delta):
	match state:
		State.IDLE:
			return;
		State.PULLING:
			if Input.is_action_pressed("LMouse"):
				var mouse_pos := get_global_mouse_position();
				if mouse_pos.distance_to(%SlingshotCenter.position) > 100:
					mouse_pos = %SlingshotCenter.position + (mouse_pos - %SlingshotCenter.position).normalized() * 100;
				%LeftLine.points[1] = mouse_pos;
				%RightLine.points[1] = mouse_pos;
			else:
				var location := get_global_mouse_position();
				var distance := location.distance_to(%SlingshotCenter.position);
				var velocity = %SlingshotCenter.position - location;
				var player : Projectile = get_tree().get_nodes_in_group("Player")[0];
				player.throw();
				player.apply_impulse(Vector2(), velocity / 50 * distance);
				state = State.THROWN;
				%LeftLine.points[1] = %SlingshotCenter;
				%RightLine.points[1] = %SlingshotCenter;
				
		State.THROWN:
			return;
		State.RESET:
			return;
	


func _on_touch_area_input_event(viewport, event, shape_idx):
	state = State.PULLING;
