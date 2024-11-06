extends Node

var total_score:int = 0
var current_score:int = 0
var score_to_beat:int = 100

var spread_coins:int = 0


var current_level:int = 1



func get_next_score_to_beat(level:int)->int:
	return level*10
	
func can_pass(time_left:float)->bool:
	var mult:float = get_mult(time_left)
	total_score += current_score*mult
	return current_score*mult > score_to_beat
	
func _add_coins(coins:int)->void:
	spread_coins += coins
	current_score += coins
	
func get_mult(time_left:float)->float:
	var current_mult:float = time_left*(-5.8) + 30
	return clampf(current_mult,1,30)

func _reset()->void:
	total_score = 0
	current_score = 0
	score_to_beat = 100
	spread_coins = 0
	current_level = 1

func _end_round(time_left:float)->void:
	if can_pass(time_left):
		SceneTransition._change_scene("res://component/menu/shop.tscn")
	else:
		SceneTransition._change_scene("res://component/menu/death_screen.tscn")
