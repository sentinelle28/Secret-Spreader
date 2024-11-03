extends CharacterBody2D

var target:Vector2
var radius_to_target:int = 100
var can_walk:bool = true
var speed:int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_choose_new_target()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_move()
	move_and_slide()


func _on_timer_timeout() -> void:
	_choose_new_target()

func _choose_new_target()->void:
	var new_angle = randf_range(0,2*PI)
	$RayCast2D.rotate(new_angle)
	target = $RayCast2D.get_collision_point()
	
func _check_distance()->void:
	if global_position.distance_to(target) < radius_to_target:
		$Timer.start(randf_range(3,10))
		can_walk = false
		
func _move()->void:
	if can_walk:
		$AnimatedSprite2D.play("walk")
		var direction:Vector2 = global_position.direction_to(target)
		velocity = direction*speed
		_change_sprite(direction)
	else:
		$AnimatedSprite2D.play("idle")
		
func _change_sprite(direction:Vector2)->void:
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction.x > 0:
		$AnimatedSprite2D.flip_h = false
