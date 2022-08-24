extends Camera2D

var velocity_c = 300
var can_moviment_rigth = false
var can_moviment_left = false


func _process(delta):
	if can_moviment_rigth and position.x <= 1536:
		position.x += velocity_c * delta
	if can_moviment_left and position.x >= 0:
		position.x -= velocity_c * delta
		
func _on_Buttond_mouse_entered():
	can_moviment_rigth = true

func _on_Buttond_mouse_exited():
	can_moviment_rigth = false

func _on_Buttone_mouse_entered():
	can_moviment_left = true

func _on_Buttone_mouse_exited():
	can_moviment_left = false

func _on_Button_options_pressed():
		$ColorRect.visible = true
		get_tree().paused = true

func _on_Button_Resume_pressed():
	get_tree().paused = false
	$ColorRect.visible = false

func _on_Button_Quit_pressed():
	get_tree().quit()
