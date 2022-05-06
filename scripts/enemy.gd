extends Node2D

const PRE_LAZER = preload("res://scenes/gun bullet.tscn")

func _ready():
	pass 

func _on_Area2D_area_entered(area):
	get_node("AnimationPlayer").play()
	get_parent().get_node("car_explosion_fx").play()
	




func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
