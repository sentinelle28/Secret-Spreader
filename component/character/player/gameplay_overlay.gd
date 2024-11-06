extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_start()
	
func _start()->void:
	$AnimationPlayer.play("start")
	$start_timer.start(3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$point_shower.text = str(Score.get_point()) + "/" + str(Score.get_next_score_to_beat(Score.current_level))
	
	$timer_label.text = "0:"+str(int($gameplay_timer.time_left))


func _on_gameplay_timer_timeout() -> void:
	Score._end_round(0)


func _on_start_timer_timeout() -> void:
	get_parent().can_move = true
	$gameplay_timer.start(60)
	$point_shower.show()
	$timer_label.show()
