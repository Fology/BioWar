extends KinematicBody2D

var velocity = Vector2()

var bullet = preload("res://Scenes/Shot_Enemy.tscn")
onready var player = get_tree().get_nodes_in_group("player")[0]

export var bullet_speed = 600
export var fire_rate = 0.2
export var life_enemy = 20
export var speed = 100
var can_fire = true

func _process(delta):
	look_at(player.position)
	if life_enemy == 0:
		queue_free()
	$ProgressBar.value = life_enemy
	
	if can_fire:	
		var bullet_instance = bullet.instance()
		bullet_instance.position = $Shot_Point.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate),"timeout")
		can_fire = true

func _physics_process(delta):
	if player:
		var direcao = (player.position - position).normalized()
		move_and_slide(direcao * speed)


func _on_colisao_enemy_body_entered(body):
	if body.is_in_group('shot_player'):
		life_enemy -= 1
