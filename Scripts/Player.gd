extends KinematicBody2D

export (int) var speed = 200
var velocity = Vector2()

export var bullet_speed = 1000
export var fire_rate = 0.3

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

func _process(delta):
	look_at(get_global_mouse_position())
	aim_and_shot()
	
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

