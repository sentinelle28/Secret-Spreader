extends Node

var highscore:int = 0
var total_score:int = 0
var current_score:int = 0
var score_to_beat:int = 50

var spread_coins:int = 0


var current_level:int = 1



func get_next_score_to_beat(level:int)->int:
	return level**2+50
	
func can_pass(time_left:float)->bool:
	var mult:float = get_mult(time_left)
	
	return current_score*mult >= score_to_beat
	
func _add_coins(coins:int)->void:
	spread_coins += coins * PlayerStats.secret_mult
	current_score += coins * PlayerStats.secret_mult
	
func get_mult(time_left:float)->float:
	var current_mult:float = time_left*(0.5)
	return clampf(current_mult,1,30)

func _reset()->void:
	total_score = 0
	current_score = 0
	score_to_beat = 50
	spread_coins = 0
	current_level = 1
	
func _check_highscore()->void:
	if total_score > highscore:
		highscore = total_score

func _reset_round()->void:
	
		
	_reset()
	PlayerStats._reset()
	Upgrade._reset()

func _end_round(time_left:float)->void:
	var mult:float = get_mult(time_left)
	total_score += current_score*mult
	if can_pass(time_left):
		current_score = 0
		current_level += 1 
		score_to_beat = get_next_score_to_beat(current_level)
		SceneTransition._change_scene("res://component/menu/shop.tscn")
	else:
		_check_highscore()
		SceneTransition._change_scene("res://component/menu/death_screen.tscn")
		
	

func get_point()->int:
	return current_score

func _pay(price:int)->void:
	spread_coins -= price

func can_pay(cost:int)->bool:
	if spread_coins >= cost:
		_pay(cost)
		return true
	return false
