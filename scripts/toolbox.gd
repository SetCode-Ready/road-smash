extends Node2D

var extra_life = 50

onready var player_car = get_node("../../car")

var velocity = 80

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	global_position.x = clamp(global_position.x, 29, 132)
	translate(Vector2(0, velocity) * delta)


func _on_ToolBoxArea2D_area_entered(area: Area2D) -> void:
	if area.name == "PLayerCollisionShape":
		player_car.life += extra_life
		queue_free()
		


func _on_VisibilityNotifier2D_viewport_exited(viewport: Viewport) -> void:
	queue_free()
