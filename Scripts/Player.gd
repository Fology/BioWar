extends KinematicBody2D

export (int) var speed = 200
var velocity = Vector2()

export var bullet_speed = 1000
export var fire_rate = 0.2
const wait_special = 5
var can_special = true
var in_use = false

export var life = 100

var bullet = preload("res://Scenes/Shot.tscn")
var can_fire = true

# Função responsavel por mirar, atirar e instanciar o tiro
func aim_and_shot():
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = $BulletPoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate),"timeout")
		can_fire = true

func _process(delta) -> void:
	look_at(get_global_mouse_position())
	aim_and_shot()
	
	if Input.is_action_just_pressed("reload") and can_special:
		in_use = true
		fire_rate = 0.05
		can_special = false
		yield(get_tree().create_timer(wait_special),"timeout")
		
		fire_rate = 0.2
		in_use = false
		yield(get_tree().create_timer(wait_special),"timeout")
		can_special = true
	
# Função responsavel por movimentar o personagem
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)

func _physics_process(delta):
	get_input()

func _on_Colisao_player_body_entered(body):
	if body.is_in_group("shot_enemy"):	
		life -= 1
