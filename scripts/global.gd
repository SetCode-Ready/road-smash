extends Node

var player_name setget set_player_name
var total_score = 0.0

func set_player_name(new_name):
	player_name = new_name

func _ready() -> void:
	SilentWolf.configure({
		"api_key": "FFgGf0PPnU9FgPbc8CMrN3foXJudnC2h42VlZfAw",
		"game_id": "RoadSmash",
		"game_version": ""
	})
	
	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/Splash.tscn"
	})
