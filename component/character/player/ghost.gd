extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_ghost()

func _ghost()->void:
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(self,"self_modulate",Color(1, 1, 1, 0),0.3)
	await tween.finished
	queue_free()
