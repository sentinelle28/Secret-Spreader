extends Control

func _ready() -> void:
	$RequierementPas.play()

func _process(_delta: float) -> void:
	$HBoxContainer/money_label.text = str(Score.spread_coins)

func _on_button_pressed() -> void:
	SceneTransition._change_scene("res://level/gameplayscene/gameplayscene.tscn")
