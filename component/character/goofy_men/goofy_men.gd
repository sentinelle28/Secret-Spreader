extends CharacterBody2D

class_name GoofyMen
@export var score_given:int = 10
var do_know_the_secret:bool = false
var target:Vector2
var radius_to_target:int = 200
var can_walk:bool = true
var speed:int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_choose_new_target()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_move()
	move_and_slide()


func _on_timer_timeout() -> void:
	_choose_new_target()

func _choose_new_target()->void:
	var new_angle = randf_range(0,2*PI)
	$RayCast2D.rotate(new_angle)
	target = $RayCast2D.get_collision_point()
	can_walk = true
	$NavigationAgent2D.target_position = target
	
func _check_distance()->void:
	if global_position.distance_to(target) < radius_to_target:
		$Timer.start(randf_range(3,10))
		velocity = Vector2.ZERO
		can_walk = false
		
func _move()->void:
	if can_walk:
		$AnimatedSprite2D.play("walk")
		var direction:Vector2 = global_position.direction_to($NavigationAgent2D.get_next_path_position())
		velocity = direction*speed
		_change_sprite(direction)
	else:
		$AnimatedSprite2D.play("idle")
		
func _change_sprite(direction:Vector2)->void:
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction.x > 0:
		$AnimatedSprite2D.flip_h = false

func _give_point()->void:
	if not do_know_the_secret:
		self_modulate = Color.hex(0xffffff20)
		
		Score._add_coins(score_given)
		
		#give points


func _on_navigation_agent_2d_navigation_finished() -> void:
	$Timer.start(randf_range(3,10))
	velocity = Vector2.ZERO
	can_walk = false
