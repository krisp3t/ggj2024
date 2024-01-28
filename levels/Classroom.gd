extends Node2D
signal shot

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_slingshot_shot():
	shot.emit();

func _on_ground_area_body_entered(body):
	if body is Projectile:
		await get_tree().create_timer(0.5).timeout;
		if is_instance_valid(body):
			body.queue_free();

