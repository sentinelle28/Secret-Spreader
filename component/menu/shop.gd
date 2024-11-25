extends Control

func _ready() -> void:
	$RequierementPas.play()

func _process(_delta: float) -> void:
	$HBoxContainer/money_label.text = str(Score.spread_coins)
