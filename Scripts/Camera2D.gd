extends Camera2D

var enemy = preload("res://Scenes/Enemy_E1.tscn")

onready var player_pos = get_node("../Player")

var difficulty = 1
var kills = 0
const time_period = 10
var time = 0

func _process(delta):
	position = player_pos.position
	if len(get_tree().get_nodes_in_group("Enemy")) <= difficulty - 1 :
		spawn_enemy()
		kills +=1
		if difficulty == kills:
			kills = 0
			difficulty += 1
	$Label.set_text(String(global.points))

func spawn_enemy():
	var enemy_instance = enemy.instance()
	while true:
		var enemy_pos = [rand_range(-800, 800),rand_range(-600, 600)]
		if enemy_pos[0] > 460 or enemy_pos[0] < -460  and enemy_pos[1] > 350 or enemy_pos[1] < -350:
			enemy_instance.position = Vector2(enemy_pos[0], enemy_pos[1])
			break
	get_tree().get_root().add_child(enemy_instance)
	print((enemy_instance.position))

func _physics_process(delta):
	$TextureProgress.value = player_pos.life
	
	time += delta
	$BarraMana.value = time
	if time > time_period and player_pos.in_use:
		emit_signal('timeout')
		time = 0
	
