extends Node2D

const PRE_LAZER = preload("res://scenes/enemy_gun_bullet.tscn")
const PRE_EXPLOSION = preload("res://scenes/explosion.tscn")

onready var player_car = get_node("../../car")

var explosion = PRE_EXPLOSION.instance()

onready var velY = rand_range(50, 120)

export var velocity = 0

export var life = 5
var dead = false

func _ready():
	$shot_timer.wait_time = 2.0
	$shot_timer.start()
	
func _process(delta: float) -> void:
	
	var _enemy = get_child(0)
	
	if !dead:
		if life == 0 and !get_node("explosion"):
			if (_enemy.name == "Van" || _enemy.name == "Truck"):
				get_parent().get_node("spawn_timer").start()
				
			if _enemy.name == "Van":
				player_car.score += 15
			elif _enemy.name == "Truck":
				player_car.score += 20
			else:
				player_car.score += 10
				
			add_child(explosion)
			explosion.global_position = global_position
			get_node("car_explosion_fx").play()
			velY = 200
		
		if explosion.finished:
			dead = true
			get_node("explosion").queue_free()
			if (_enemy.name == "CarGrey"):
				_enemy.set_texture(load("res://sprites/enemy_crashed.png"))
			else:
				queue_free()
		
	global_position.x = clamp(global_position.x, 29, 132)
	translate(Vector2(0, velocity if velocity > 0 else velY) * delta)
	

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
	if (get_child(0).name == "Truck" || get_child(0).name == "Van"):
		get_parent().get_node("spawn_timer").start()
		
	queue_free()
