extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_start()
	
func _start()->void:
	$AnimationPlayer.play("start")
	$start_timer.start(3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_gameplay_timer_timeout() -> void:
	Score._end_round(0)


func _on_start_timer_timeout() -> void:
	get_parent().can_move = true
