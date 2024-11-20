extends TileMapLayer

@export var proba:int = 8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if randi_range(1,10) > proba:
		queue_free()
