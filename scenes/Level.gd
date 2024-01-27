extends Node2D

func _ready():
	%LaughProgressBar.value = 50.0;

func _process(delta):
	%EraserProgressBar.value = %EraserTimer.time_left / %EraserTimer.wait_time;
	%SpitballProgressBar.value = %SpitballTimer.time_left / %SpitballTimer.wait_time;
	%LaughProgressBar.value -= 0.9 * delta;
	
func _on_eraser_timer_timeout():
	%EraserButton.disabled = false;

func _on_spitball_timer_timeout():
	%SpitballButton.disabled = false;

func _on_eraser_button_pressed():
	%EraserButton.disabled = true;
	%EraserTimer.start();

func _on_spitball_button_pressed():
	%SpitballButton.disabled = true;
	%SpitballButton.start();
