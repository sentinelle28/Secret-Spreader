extends Control


func _process(_delta: float) -> void:
	$HBoxContainer/money_label.text = Score.spread_coins

func _on_button_pressed() -> void:
	SceneTransition._change_scene("res://level/gameplayscene/gameplayscene.tscn")
