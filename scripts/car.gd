extends Node2D

export var velocity = 120

const PRE_LAZER = preload("res://scenes/player_gun_bullet.tscn")
const PRE_EXPLOSION = preload("res://scenes/explosion.tscn")

var explosion = PRE_EXPLOSION.instance()

var score = 0

var life = 100.0
var dead = false

export var bullet = 8
var reloading = false

func _ready():
	pass

func _process(delta):
	
	score += delta * 1
	
	if !dead:
		if life <= 0 and !get_node("explosion"):    
			add_child(explosion)
			explosion.global_position = global_position
			get_parent().get_node("car_explosion_fx").play()
			velocity = 0
			
		if explosion.finished:
			dead = true
			get_node("explosion").queue_free()
			$CarRed.set_texture(load("res://sprites/enemy_crashed.png"))
			get_tree().change_scene("res://scenes/start_scene.tscn")
	
	var dirX = 0
	var dirY = 0
	
	if Input.is_key_pressed(KEY_R):
		if bullet >= 0 and !reloading:
			reloading = true
			get_parent().get_node("gun_reload_fx").play()
	
	if Input.is_action_pressed("ui_up"):
		dirY += -1
		
	if Input.is_action_pressed("ui_down"):
		dirY += 1
	
	if Input.is_action_pressed("ui_right"):
		dirX += 1
	
	if Input.is_action_pressed("ui_left"):
		dirX += -1
		
	if Input.is_action_just_pressed("ui_accept"):
		if bullet > 0:
			bullet -= 1
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
	bullet = 8
	reloading = false


func _on_PLayerCollisionShape_area_entered(area):
	if(area.get_name() == "EnemyGunBulletArea" || area.get_name() == "EnemyArea"):
		life -= 25	
		get_parent().get_node("car_explosion_fx").play()
