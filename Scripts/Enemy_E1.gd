extends KinematicBody2D

var velocity = Vector2()

var bullet = preload("res://Scenes/Shot_Enemy.tscn")
onready var player = get_tree().get_nodes_in_group("player")[0]

export (int) var speed = 150
export var bullet_speed = 600
export var fire_rate = 0.3

var can_fire = true
	
func _process(delta):
	look_at(player.position)
	
	if can_fire:	
		var bullet_instance = bullet.instance()
		bullet_instance.position = $Shot_Point.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate),"timeout")
		can_fire = true
