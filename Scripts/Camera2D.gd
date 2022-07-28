extends Camera2D

onready var player_pos = get_node("../Player")
func _process(delta):
	position = player_pos.position
