extends Node2D

const PRE_LAZER = preload("res://scenes/enemy_gun_bullet.tscn")
const PRE_EXPLOSION = preload("res://scenes/explosion.tscn")

onready var player_car = get_node("../../car")

var explosion = PRE_EXPLOSION.instance()

onready var velY = rand_range(50, 120)

var life = 3
var dead = false

func _ready():
	$shot_timer.wait_time = 2.0
	$shot_timer.start()
	
func _process(delta: float) -> void:
	
	if !dead:
		if life == 0 and !get_node("explosion"):
			player_car.score += 10			  
			add_child(explosion)
			explosion.global_position = global_position
			get_node("car_explosion_fx").play()
			velY = 200
		
		if explosion.finished:
			dead = true
			get_node("explosion").queue_free()
			$CarGrey.set_texture(load("res://sprites/enemy_crashed.png"))
		
	global_position.x = clamp(global_position.x, 29, 132)
	translate(Vector2(0, velY) * delta)
	

func _on_Area2D_area_entered(area):
	if area.get_name() == "PlayerGunBulletArea":
		get_node("damage_fx").play()
		life -= 1

func _on_shot_timer_timeout() -> void:
	if life > 0:
		var lazer = PRE_LAZER.instance()
		add_child(lazer)
		lazer.global_position = global_position
		get_node("gun_shoot_fx").play()


func _on_VisibilityNotifier2D_viewport_exited(viewport: Viewport) -> void:
	queue_free()
