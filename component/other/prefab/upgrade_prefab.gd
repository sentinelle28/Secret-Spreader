extends Label

class_name UpgradePrefab

func _set_text(tex:String)->void:
	text = "+ " + tex
	$AnimationPlayer.play("fade_away")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_parent().remove_child(self)
