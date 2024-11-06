extends CanvasLayer

var scene_to_change_to:String
func _change_scene(new_scene:String)->void:
	show()
	scene_to_change_to = new_scene
	$Timer.start(1.5)
	$AnimationPlayer.play("Transition")


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file(scene_to_change_to)
	get_tree().paused = true
	
	
	


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_tree().paused = false
	hide()
