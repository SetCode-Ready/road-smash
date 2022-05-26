extends Node2D

var opcao = 0

func _ready() -> void:
	$NamePanel.hide()
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
				$NamePanel.show()
			1:
				get_tree().quit()
		
	$arrow.global_position = $itens.get_child(opcao).global_position + Vector2(-10, 8)



func _on_SubmitName_pressed() -> void:
	var name = $"NamePanel/NameInput".text
	Global.set_player_name(name)
	SilentWolf.Scores.persist_score(Global.player_name, Global.total_score)
	SilentWolf.Scores.get_high_scores()
	$"NamePanel".hide()
	get_tree().change_scene("res://scenes/game.tscn")
