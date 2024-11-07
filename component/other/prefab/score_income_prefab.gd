extends Label

class_name ScoreIncomePrefab
func _set_score(value:int)->void:
	text = "+ " + str(value)
	$AnimationPlayer.play("fade_away")



func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_parent().remove_child(self)
