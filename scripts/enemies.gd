extends Node2D

const PRE_ENEMY = preload("res://scenes/enemy.tscn")
const PRE_VAN_ENEMY = preload("res://scenes/van_enemy.tscn")
const PRE_TRUCK_ENEMY = preload("res://scenes/truck_enemy.tscn")

var van_spawn_mark = 20
var truck_spawn_mark = 40

func _ready() -> void:
	restart_timer()


func _on_spawn_timer_timeout() -> void:
	randomize()
	if (get_child_count() <= 3):
		var enemy = PRE_ENEMY.instance()
		add_child(enemy)
		enemy.global_position = Vector2(rand_range(40, 120), -60)
		restart_timer()
	

func restart_timer():
	$spawn_timer.wait_time = rand_range(1, 3)
	$spawn_timer.start()


func _process(delta: float) -> void:
	var car = get_parent().get_node("car")
	
	if (int(car.distance) == van_spawn_mark):
		$spawn_timer.stop()
		van_spawn_mark += 20
		var van_enemy = PRE_VAN_ENEMY.instance()
		van_enemy.global_position = Vector2(rand_range(40, 120), -60)
		add_child(van_enemy)
		
	if (int(car.distance) == truck_spawn_mark):
		$spawn_timer.stop()
		truck_spawn_mark += 40
		var truck_enemy = PRE_TRUCK_ENEMY.instance()
		truck_enemy.global_position = Vector2(rand_range(40, 120), -60)
		add_child(truck_enemy)
		
	
