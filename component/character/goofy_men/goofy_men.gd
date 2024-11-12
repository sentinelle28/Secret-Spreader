extends CharacterBody2D

class_name GoofyMen
@export var score_given:int = 10
@export var label_prefab:PackedScene
var do_know_the_secret:bool = false
var target:Vector2
var radius_to_target:int = 200
var can_walk:bool = true
var speed:int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_choose_new_target()
	score_given = PlayerStats.better_goofy_men


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_move()
	move_and_slide()


func _on_timer_timeout() -> void:
	_choose_new_target()

func _choose_new_target()->void:
	target  = Vector2(randi_range(0,1000),randi_range(0,1000))
	can_walk = true
	$NavigationAgent2D.target_position = target
	
func _check_distance()->void:
	if global_position.distance_to(target) < radius_to_target:
		_wait()
		
func _move()->void:
	if can_walk:
		$AnimatedSprite2D.play("walk")
		var direction:Vector2 = global_position.direction_to($NavigationAgent2D.get_next_path_position())
		velocity = direction*speed
		_change_sprite(direction)
	else:
		$AnimatedSprite2D.play("idle")
		velocity = Vector2.ZERO
		
func _change_sprite(direction:Vector2)->void:
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction.x > 0:
		$AnimatedSprite2D.flip_h = false

func _give_point()->void:
	if not do_know_the_secret:
		#visual indicator
		self_modulate = Color.hex(0xffffff20)
		
		#give points
		Score._add_coins(score_given)
		
		#add visual indicator
		var new_child:ScoreIncomePrefab = label_prefab.instantiate()
		add_child(new_child)
		new_child._set_score(score_given)
		
		do_know_the_secret = true


func _on_navigation_agent_2d_navigation_finished() -> void:
	_wait()

func _wait()->void:
	$Timer.start(randf_range(3,10))
	velocity = Vector2.ZERO
	can_walk = false
