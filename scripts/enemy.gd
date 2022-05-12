extends Node2D

const PRE_LAZER = preload("res://scenes/enemy_gun_bullet.tscn")
const PRE_EXPLOSION = preload("res://scenes/explosion.tscn")

var explosion = PRE_EXPLOSION.instance()

onready var velY = rand_range(50, 120)

var life = 3

func _ready():
	$shot_timer.wait_time = 2.0
	$shot_timer.start()
	
	
	
func _process(delta: float) -> void:
	
	if life == 0 and !get_node("explosion") and !explosion.finished:    
		
		add_child(explosion)
		explosion.global_position = global_position
		get_node("car_explosion_fx").play()
		velY = 200
	
	if explosion.finished:
		explosion.visible = false
		$CarGrey.set_texture(load("res://sprites/enemy_crashed.png"))
		
	global_position.x = clamp(global_position.x, 29, 132)
	translate(Vector2(0, velY) * delta)
	

func _on_Area2D_area_entered(area):
	if area.get_name() == "PlayerGunBulletArea":
		get_node("damage_fx").play()
		life -= 1

func _on_shot_timer_timeout() -> void:
	var lazer = PRE_LAZER.instance()
	get_parent().add_child(lazer)
	lazer.global_position = global_position
	get_node("gun_shoot_fx").play()


func _on_VisibilityNotifier2D_viewport_exited(viewport: Viewport) -> void:
	queue_free()
