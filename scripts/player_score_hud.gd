extends CanvasLayer

var score

var score_label = "{score}"
func _ready() -> void:
	$player_score_hud_container/player_score.text = score_label


func _process(delta: float) -> void:
	score = get_parent().get_node("car").score
	var actual_score_label = score_label.format({"score" : +(int(score))})
	$player_score_hud_container/player_score.text = actual_score_label
