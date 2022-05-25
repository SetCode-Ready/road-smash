extends Node2D

var opcao = 0

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_down"):
		opcao += 1
		
	if Input.is_action_just_pressed("ui_up"):
		opcao -= 1
		
	if opcao < 0:
		opcao = $itens.get_child_count() - 1
		
	if opcao > $itens.get_child_count() - 1:
		opcao = 0
		
	if Input.is_action_just_pressed("ui_accept"):
		match opcao:
			0:
				get_tree().change_scene("res://scenes/game.tscn")
			1:
				get_tree().quit()
		
	$arrow.global_position = $itens.get_child(opcao).global_position + Vector2(-10, 4)
