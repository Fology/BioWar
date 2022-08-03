extends Camera2D

var enemy = preload("res://Scenes/Enemy_E1.tscn")

onready var player_pos = get_node("../Player")

var difficulty = 1
var kills = 0

	
func _process(delta):
	position = player_pos.position
	if len(get_tree().get_nodes_in_group("Enemy")) <= difficulty - 1 :
		spawn_enemy()
		kills +=1
		if difficulty == kills:
			kills = 0
			difficulty += 1

func spawn_enemy():
	var enemy_instance = enemy.instance()
	while true:
		var enemy_pos = [rand_range(-800, 800),rand_range(-600, 600)]
		if enemy_pos[0] > 460 or enemy_pos[0] < -460  and enemy_pos[1] > 350 or enemy_pos[1] < -350:
			enemy_instance.position = Vector2(enemy_pos[0], enemy_pos[1])
			break
	enemy
	get_tree().get_root().add_child(enemy_instance)

func _physics_process(delta):
	$TextureProgress.value = player_pos.life
