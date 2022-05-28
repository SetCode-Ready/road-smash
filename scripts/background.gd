extends Sprite

export (NodePath) var car

var time = 0.0

func _ready() -> void:
	
	if car:
		car = get_node(car)
	else: 
		set_process(false)


func _process(delta: float) -> void:
	var player = get_node("../car")
	if player.dead == true:
		set_process(false)
	time += delta
	material.set_shader_param("time", time)
