extends TextureButton

@export_category("cost related")
@export var cost:int = 10
@export var max_upgrade:int = 1
@export var current_upgrade_level:int = 0
@export_category("benefit related")
@export var related_var:String = "base_speed"
@export var is_bool:bool = false
@export var power_increase:float = 10


func _on_pressed() -> void:
	if current_upgrade_level + 1 <= max_upgrade:
		if Score.spread_coins - cost >= 0:
			Score._pay(cost)
			_upgrade()
		

func _upgrade()->void:
	current_upgrade_level += 1
	if is_bool:
		_activate_new_function()
	else:
		_add_power()
	
func _activate_new_function()->void:
	PlayerStats._custom_set(related_var,true)
	
	
func _add_power()->void:
	PlayerStats._add(related_var,power_increase)
