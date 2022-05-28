extends Node2D

const PRE_TOOLBOX = preload("res://scenes/toolbox.tscn")

onready var player_car = get_node("../car")

var timeStarted = false

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if player_car.life <= 50 and !timeStarted:
		timeStarted = true
		$toolbox_spawn_timer.wait_time = 3.0
		$toolbox_spawn_timer.start()
	elif player_car.life > 50 and timeStarted:
		timeStarted = false
		$toolbox_spawn_timer.stop()
		

func _on_spawn_timer_timeout() -> void:
	if get_child_count() < 2:
		var toolbox = PRE_TOOLBOX.instance()
		toolbox.global_position = Vector2(rand_range(40, 120), -60)
		add_child(toolbox)
