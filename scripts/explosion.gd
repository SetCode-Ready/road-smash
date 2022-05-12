extends Node2D

var finished = false

func _on_explosion_animation_animation_finished(anim_name):
	finished = true	
