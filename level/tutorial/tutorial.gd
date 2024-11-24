extends Node2D




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		SceneTransition._change_scene("res://level/gameplayscene/gameplayscene.tscn")
