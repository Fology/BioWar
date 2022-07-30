extends Camera2D

var enemy = preload("res://Scenes/Enemy_E1.tscn")
onready var player_pos = get_node("../Player")

var life = $TextureProgress.value
func _ready():
	life = 10
	
func _process(delta):
	position = player_pos.position
	if len(get_tree().get_nodes_in_group("Enemy")) <= 4*4:
		spawn_enemy()

func spawn_enemy():
	var enemy_instance = enemy.instance()
	while true:
		var enemy_pos = [rand_range(-800, 800),rand_range(-600, 600)]
		if enemy_pos[0] > 460 or enemy_pos[0] < -460  and enemy_pos[1] > 350 or enemy_pos[1] < -350:
			enemy_instance.position = Vector2(enemy_pos[0], enemy_pos[1])
			break
	enemy
	get_tree().get_root().add_child(enemy_instance)
