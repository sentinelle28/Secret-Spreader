extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("fadeout")
	_fix_position()
	_set_text()

func _set_text()->void:
	text = PossibleDialogue._give_random_dialogue()

func _fix_position()->void:
	position = Vector2(-size.x/2,-10-size.y/2)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
