extends CharacterBody2D

class_name Player
@export var base_speed:int = 300
@export var max_stamina:int = 100
@export var stamina_regen:float = 1.2



@onready var stamina:int = max_stamina

var is_running:bool = false
var stamina_mult:float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_regen_stamina()
	_move()
	move_and_slide()
	

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
