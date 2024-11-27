extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Failure.play()
	$circle_label2/Label2.text = str(Score.total_score)
	$circle_label/Label2.text = str(Score.current_level)
	$circle_label3/Label2.text = str(Score.highscore)
	if not PlayerStats.did_cheat:
		$circle_label4.hide()
	Score._reset_round()
