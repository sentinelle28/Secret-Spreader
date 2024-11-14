extends Node2D

@export_category("Circle related")
@export var color:Color
@export var radius:int = 10

@export_category("Upgrade related")
@export var current_upgrade:int = 0
@export var max_upgrade:int = 10
@export var related_var:String = "base_speed"
@export var name_of_upgrade:String = "+ base speed"
@export var cost:int = 10



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_init_upgrade()
	_set_up_button()


func _draw() -> void:
	var end_angle:float = float(current_upgrade)/float(max_upgrade)*2*PI
	draw_circle(Vector2.ZERO,radius,Color.GRAY,true)
	draw_arc(Vector2.ZERO,radius,0,end_angle,1000,color,radius/2)

func _upgrade():
	_add_point()

func _add_point()->void:
	current_upgrade += 1
	Upgrade._set_upgrade(related_var,current_upgrade)
	
	
func can_buy()->bool:
	return Score.can_pay(cost)

func _init_upgrade()->void:
	if related_var in Upgrade.upgrade_dict:
		current_upgrade = Upgrade.get_upgrade(related_var)
	else:
		Upgrade.upgrade_dict[related_var] = 0

func _set_up_button()->void:
	$Button.set_size(Vector2(radius*2,radius*2))
	$Button.set_position(Vector2(-radius,-radius))


func _on_button_pressed() -> void:
	if current_upgrade + 1 <= max_upgrade:
		if Score.can_pay(cost):
			_upgrade()
			_spawn_indicator()
			queue_redraw()

func _spawn_indicator()->void:
	var child:UpgradePrefab = load("res://component/other/prefab/upgrade_prefab.tscn").instantiate()
	add_child(child)
	child._set_text(name_of_upgrade)
