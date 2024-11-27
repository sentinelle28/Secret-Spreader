extends Node2D

@export_category("Circle related")
@export var color:Color
@export var radius:int = 10

@export_category("Upgrade related")
@export var current_upgrade:int = 0
@export var max_upgrade:int = 10
@export var cost:int = 10
@export var strenght:float = 1

@export_category("name")
@export var related_var:String = "base_speed"
@export var name_of_upgrade:String = "+ base speed"
@export var text_label:String = "base speed"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_init_upgrade()
	_set_up_button()
	$Label.text = text_label

func _process(_delta: float) -> void:
	if Score.spread_coins >= get_current_cost():
		self_modulate = Color(1, 1, 1)
	else:
		self_modulate = Color(1, 1, 1, 0.247)
		

func _draw() -> void:
	var end_angle:float = float(current_upgrade)/float(max_upgrade)*2*PI
	draw_circle(Vector2.ZERO,radius,Color.GRAY,true)
	#draw_arc(Vector2.ZERO,radius,0,2*PI,1000,Color.BLACK,radius/2)
	draw_arc(Vector2.ZERO,radius,0,end_angle,1000,color,radius/2)

func _upgrade():
	_add_point()
	PlayerStats._add(related_var,strenght)

func _add_point()->void:
	current_upgrade += 1
	Upgrade._set_upgrade(related_var,current_upgrade)
	
	

func _init_upgrade()->void:
	if related_var in Upgrade.upgrade_dict:
		current_upgrade = Upgrade.get_upgrade(related_var)
	else:
		Upgrade.upgrade_dict[related_var] = 0

func _set_up_button()->void:
	$Button.set_size(Vector2(radius*2,radius*2))
	$Button.set_position(Vector2(-radius,-radius))

func get_current_cost()->int:
	return cost*(current_upgrade+1)

func _on_button_pressed() -> void:
	if current_upgrade + 1 <= max_upgrade:
		if Score.can_pay(get_current_cost()):
			_upgrade()
			_spawn_indicator()
			queue_redraw()
		else:
			var child:UpgradePrefab = load("res://component/other/prefab/upgrade_prefab.tscn").instantiate()
			add_child(child)
			child._set_text("can't buy")
			child.self_modulate = Color(0.686, 0, 0)

func _spawn_indicator()->void:
	var child:UpgradePrefab = load("res://component/other/prefab/upgrade_prefab.tscn").instantiate()
	add_child(child)
	child._set_text(name_of_upgrade)
