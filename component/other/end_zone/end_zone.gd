extends Area2D

var is_player_in:bool = false
var player:Player

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_player_in :
		player.gameplay_overlay._end_round()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		is_player_in = true
		if player == null:
			player = body


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		is_player_in = false
