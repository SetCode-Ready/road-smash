extends CanvasLayer

var life

var bullet

var ammo_label = "{bullet} / 8"

func _ready():
	life = get_parent().get_node("car").life
	$player_life_bar.value = life
	$ammo_hud_container/player_ammo.text = ammo_label


func _process(_delta):
	life = get_parent().get_node("car").life
	$player_life_bar.value = life
	
	bullet = get_parent().get_node("car").bullet
	if get_parent().get_node("car").reloading:
		$ammo_hud_container/player_ammo.text = "reloading..."
	else: 
		var actual_ammo_label = ammo_label.format({"bullet" : +(bullet)})
		$ammo_hud_container/player_ammo.text = actual_ammo_label
