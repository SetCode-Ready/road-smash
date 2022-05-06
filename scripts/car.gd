extends Node2D

var velocity = 120
const PRE_LAZER = preload("res://scenes/gun bullet.tscn")

var bullet = 1
var reloading = false

func _ready():
	pass

func _process(delta):
	
	var dirX = 0
	var dirY = 0
	
	if Input.is_action_pressed("ui_up"):
		dirY += -1
		
	if Input.is_action_pressed("ui_down"):
		dirY += 1
	
	if Input.is_action_pressed("ui_right"):
		dirX += 1
	
	if Input.is_action_pressed("ui_left"):
		dirX += -1
		
	if Input.is_action_just_pressed("ui_accept"):
		if bullet < 9:
			bullet += 1
			var lazer = PRE_LAZER.instance()
			get_parent().add_child(lazer)
			lazer.global_position = global_position
			get_parent().get_node("gun_shoot_fx").play()
		else:			
			if(!reloading):
				reloading = true
				get_parent().get_node("gun_reload_fx").play()
		
	
	translate(Vector2(dirX, dirY) * velocity * delta)
	global_position.x = clamp(global_position.x, 29, 132)
	global_position.y = clamp(global_position.y, 16, 670)


func _on_gun_reload_fx_finished():
	bullet = 1
	reloading = false
