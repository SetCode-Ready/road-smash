extends CanvasLayer

var life

var life_label = "{life}"

var bullet

var ammo_label = "{bullet} / 8"

func _ready():
	$life_hud_container/player_life.text = life_label
	$ammo_hud_container/player_ammo.text = ammo_label


func _process(_delta):
	life = get_parent().get_node("car").life
	var actual_life_label = life_label.format({"life" : +(life)})
	$life_hud_container/player_life.text = actual_life_label
	
	bullet = get_parent().get_node("car").bullet
	if get_parent().get_node("car").reloading:
		$ammo_hud_container/player_ammo.text = "reloading..."
	else: 
		var actual_ammo_label = ammo_label.format({"bullet" : +(bullet)})
		$ammo_hud_container/player_ammo.text = actual_ammo_label
