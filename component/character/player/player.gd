extends CharacterBody2D

class_name Player
@export var base_speed:int = 300
@export var max_stamina:int = 100
@export var stamina_regen:float = 1.2
@export var area_of_influence:int = 12


@onready var stamina:int = max_stamina

var is_running:bool = false
var stamina_mult:float = 1

#animation for the circle
var offset:float = 0

var can_move:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_init()
	
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
		_regen_stamina()
		_move()
		move_and_slide()
	
func _draw() -> void:
	for i in range(0,361,15):
		draw_arc(Vector2.ZERO,float(area_of_influence),deg_to_rad(i*15)+offset,deg_to_rad((i+1)*15)+offset,100,Color(0, 1, 1, 0.318),1)


func _move()->void:
	var direction:Vector2 = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	_check_run()
	velocity = direction*base_speed*stamina_mult
	_change_sprite(direction)
	_change_animation(velocity)

func _change_sprite(direction:Vector2)->void:
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction.x > 0:
		$AnimatedSprite2D.flip_h = false

func _change_animation(force:Vector2)->void:
	if force == Vector2.ZERO:
		$AnimatedSprite2D.play("idle")
	elif force != Vector2.ZERO and is_running:
		$AnimatedSprite2D.play("run")
	elif force != Vector2.ZERO and not is_running:
		$AnimatedSprite2D.play("walk")

func _check_run()->void:
	if Input.is_action_pressed("run") and stamina > 0:
		is_running = true
		stamina_mult = 1.1 #to connect to player stats autoload
	elif Input.is_action_just_released("run") or stamina < 0:
		is_running = false
		stamina_mult = 1

func _regen_stamina()->void:
	if not is_running:
		stamina = lerp(stamina,max_stamina,stamina_regen)
	 

func _on_zone_of_influence_body_entered(body: Node2D) -> void:
	if body is GoofyMen:
		body._give_point()
