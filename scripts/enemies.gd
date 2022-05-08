extends Node2D

const PRE_ENEMY = preload("res://scenes/enemy.tscn")

func _ready() -> void:
	restart_timer()


func _on_spawn_timer_timeout() -> void:
	if (get_child_count() <= 6):
		var enemy = PRE_ENEMY.instance()
		add_child(enemy)
		enemy.global_position = Vector2(rand_range(40, 120), -60)
		restart_timer()
	


func restart_timer():
	$spawn_timer.wait_time = rand_range(1, 3)
	$spawn_timer.start()
