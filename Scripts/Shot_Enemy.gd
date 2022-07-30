extends RigidBody2D

func _on_Shot_body_entered(body):
	if !body.is_in_group("Enemy"):
		queue_free()


func _on_Timer_timeout():
	queue_free()
