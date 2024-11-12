extends Control

class_name GameplayOverlay
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_start()
	
func _start()->void:
	$AnimationPlayer.play("start")
	$start_timer.start(3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_calibrate_bar()
	
	$timer_label.text = "0:"+str(int($gameplay_timer.time_left))

func _calibrate_bar()->void:
	$point_shower.max_value = Score.get_next_score_to_beat(Score.current_level)
	$point_shower.value = Score.get_point()
	if Score.can_pass(0) and not $PointS_animator.is_playing():
		$PointS_animator.play("glow")
	else:
		$point_shower.tint_progress = Color.BLACK


func _on_gameplay_timer_timeout() -> void:
	_end_round()

func _end_round()->void:
	Score._end_round($gameplay_timer.time_left)

func _on_start_timer_timeout() -> void:
	get_parent().can_move = true
	$gameplay_timer.start(60)
	$point_shower.show()
	



func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	$timer_label.show()
