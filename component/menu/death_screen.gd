extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Failure.play()
	$Panel/score.text = str(Score.total_score)
	$Panel/day.text = str(Score.current_level)


func _on_button_pressed() -> void:
	Score._reset_round()
	SceneTransition._change_scene("res://level/gameplayscene/gameplayscene.tscn")
