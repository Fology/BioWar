extends Node2D

var speed = 200
var current_state := 0
export var direction = 1
enum {IDLE, RUN, ATTACK}
var can_run = true
var can_attack = false

func _ready():
	scale.x = scale.x * direction

func _physics_process(delta):
	match current_state:
		IDLE:
			_idle_state()
		RUN:
			_run_state(delta)
		ATTACK:
			_attack_state()
	
# Check Functions
func _check_idle_state():
	var new_state = current_state
	if can_run:
		new_state = RUN
	return new_state

func _check_run_state():
	var new_state = current_state
	if position.x >= 2400*direction:
		new_state = IDLE
		can_run = false
	if can_run == false:
		new_state = IDLE
	if can_run == false and can_attack:
		new_state = ATTACK
	return new_state

func _check_attack_state():
	var new_state = current_state
	if can_attack == false:
		new_state = IDLE
	if can_attack == false and can_run:
		new_state = RUN
	return new_state
	
#State Functions
func _idle_state():
	$Player_area/AnimationPlayer.play("RESET")
	current_state = _check_idle_state()

func _run_state(_delta):
	_run(_delta)
	$Player_area/AnimationPlayer.play("Run")
	current_state = _check_run_state()
	
func _attack_state():
	$Player_area/AnimationPlayer.play("Attack")
	current_state = _check_attack_state()
	
#Helpers
func _run(_delta):
	position.x += speed * _delta * direction

# Inputs
func _on_Detect_InFront_area_entered(area):
	if area.is_in_group('enemy'):
		can_attack = true
		can_run = false
	if area.is_in_group('player'):
		can_run = false



func _on_Detect_InFront_area_exited(area) -> void:
	can_run = true
	can_attack = false

