extends Node2D

const PRE_LAZER = preload("res://scenes/enemy_gun_bullet.tscn")

onready var velY = rand_range(50, 120)

func _ready():
	$shot_timer.wait_time = 2.0
	$shot_timer.start()
	
	
func _process(delta: float) -> void:
	global_position.x = clamp(global_position.x, 29, 132)
	translate(Vector2(0, velY) * delta)
	

func _on_Area2D_area_entered(area):
	if area.get_name() == "PlayerGunBulletArea":
		get_node("car_explosion_fx").play()
		#queue_free()
	#get_node("AnimationPlayer").play()
	#queue_free()


#func _on_AnimationPlayer_animation_finished(anim_name):
#	queue_free()


func _on_shot_timer_timeout() -> void:
	var lazer = PRE_LAZER.instance()
	get_parent().add_child(lazer)
	lazer.global_position = global_position
	get_node("gun_shoot_fx").play()


func _on_VisibilityNotifier2D_viewport_exited(viewport: Viewport) -> void:
	queue_free()
