extends Node2D




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		Score._reset()
		SceneTransition._change_scene("res://level/mainmenu/mainmenu.tscn")
