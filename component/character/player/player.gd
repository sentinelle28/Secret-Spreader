extends CharacterBody2D

class_name Player
@export var gameplay_overlay:GameplayOverlay
@export var base_speed:int = 200
@export var max_stamina:int = 100
@export var stamina_regen:float = 1.4
@export var area_of_influence:int = 12
@export var max_acceleration:float = 1.2
@export var acceleration_factor:float = 0.01
@export var ghost_threshold:int = 350


@onready var stamina:float = max_stamina

var stamina_mult:float = 1
var current_acceleration:float = 1

#animation for the circle
var offset:float = 0

var can_move:bool = false
var is_truly_running:bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	_init()
	_set_area_of_influence(area_of_influence)
	
func _init()->void:
	base_speed = PlayerStats.base_speed
	max_stamina = PlayerStats.max_stamina
	stamina_regen = PlayerStats.stamina_regen
	area_of_influence = PlayerStats.area_of_influence
	stamina_mult = PlayerStats.stamina_mult
	

func _set_area_of_influence(radius:int)->void:
	$zone_of_influence/CollisionShape2D.shape.radius = radius

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_move:
		offset += delta
		queue_redraw()
		_regen_stamina(delta)
		_move(delta)
		move_and_slide()
	
func _draw() -> void:
	for i in range(0,361,15):
		draw_arc(Vector2.ZERO,float(area_of_influence),deg_to_rad(i*15)+offset,deg_to_rad((i+1)*15)+offset,100,Color(0, 1, 1, 0.318),1)
	
	if stamina != max_stamina:
		var end_angle:float = (stamina/max_stamina)*2*PI
		draw_arc(Vector2(10,-10),4,0,end_angle,1000,Color.GREEN,4)

func _move(delta:float)->void:
	var direction:Vector2 = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	_check_run(delta)
	_accelerate()
	velocity = direction*base_speed*stamina_mult*current_acceleration
	_change_sprite(direction)
	_change_animation(velocity)
	_ghost()
	
func _accelerate()->void:
	if velocity == Vector2.ZERO:
		current_acceleration = 1
		
	elif velocity != Vector2.ZERO:
		current_acceleration = lerp(current_acceleration,max_acceleration,acceleration_factor)

func _run_particle(direction:Vector2)->void:
	if is_running():
		$CPUParticles2D.emitting = true
		$CPUParticles2D.gravity = direction*300
	else:
		$CPUParticles2D.emitting = false


func _change_sprite(direction:Vector2)->void:
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction.x > 0:
		$AnimatedSprite2D.flip_h = false

func _change_animation(force:Vector2)->void:
	if force == Vector2.ZERO:
		$AnimatedSprite2D.play("idle")
	elif force != Vector2.ZERO and is_running():
		$AnimatedSprite2D.play("run")
	elif force != Vector2.ZERO and not is_running():
		$AnimatedSprite2D.play("walk")

func _check_run(delta:float)->void:
	if Input.is_action_pressed("run") and stamina > 0:
		stamina_mult = 1.1 #to connect to player stats autoload
		stamina -= delta*10
		is_truly_running = true
	elif Input.is_action_just_released("run") or stamina <= 0:
		stamina_mult = 1
		is_truly_running = false

func _regen_stamina(delta:float)->void:
	if not is_running():
		stamina += stamina_regen*delta
		stamina = clampf(stamina,0,max_stamina)
	 

func _on_zone_of_influence_body_entered(body: Node2D) -> void:
	if body is GoofyMen:
		body._give_point()

func is_running()->bool:
	return is_truly_running

func _stun():
	$AnimatedSprite2D.play("stun")
	can_move = false
	await $AnimatedSprite2D.animation_finished
	can_move = true

func _ghost()->void:
	
	if abs(velocity.x) + abs(velocity.y) >= ghost_threshold:
		
		if $ghost_timer.time_left == 0:
			$ghost_timer.start(0.15)


func _on_ghost_timer_timeout() -> void:
	var ghost:Node2D = load("res://component/character/player/ghost.tscn").instantiate()
	get_parent().call_deferred("add_child",ghost)
	ghost.global_position = global_position
