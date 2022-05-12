extends CanvasLayer

var bullet

var ammo_label = "{bullet} / 8"

func _ready():
	$container/player_ammo.text = ammo_label


func _process(_delta):
	bullet = get_parent().get_node("car").bullet
	if get_parent().get_node("car").reloading:
		$container/player_ammo.text = "reloading..."
	else: 
		var actual_label = ammo_label.format({"bullet" : +(bullet)})
		$container/player_ammo.text = actual_label
