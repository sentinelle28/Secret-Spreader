extends CanvasLayer


signal UpdateStats
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("end_cheat"):
		var text1:String = $TextEdit.text.erase(len($TextEdit.text)-1)
		$TextEdit.text = text1
		_check_input(text1)


func _consol()->void:
	visible = not visible
	
func _check_input(text:String)->void:
	match text:
		"help":
			$TextEdit.text = "IwantMoney|IamCool|Shout|SpeedyBoy|TurtleSpeed \n
			Sunglasses|NarutoRun|InfiniteStamina"
		"IwantMoney":
			Score.spread_coins += 100
			_correct_cheat()
		"IamCool":
			Score.current_score += 100
			_correct_cheat()
		"Shout":
			Score._add_coins(100)
			_correct_cheat()
		"SpeedyBoy":
			PlayerStats.base_speed += 50
			_correct_cheat()
		"TurtleSpeed":
			PlayerStats.base_speed -= 50
			_correct_cheat()
		"Sunglasses":
			PlayerStats.area_of_influence += 10
			_correct_cheat()
		"NarutoRun":
			PlayerStats.stamina_mult += 0.5
			_correct_cheat()
		"InfiniteStamina":
			PlayerStats.stamina_regen += 2
			_correct_cheat()

func _correct_cheat():
	$TextEdit.text = "cheat code correct"
	emit_signal("UpdateStats") 
