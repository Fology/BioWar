extends Node2D


func _on_ButtonStart_pressed():
	$AudioStreamPlayer.playing = false
	$AudioStreamPlayer2.play()
	yield(get_tree().create_timer(3.3),"timeout")
	get_tree().change_scene("res://Scenes/Main.tscn")

func _on_ButtonQuit_pressed():
	get_tree().quit()
