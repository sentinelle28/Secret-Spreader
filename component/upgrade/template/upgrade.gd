extends TextureButton

class_name UpgradeBase
@export_category("cost related")
@export var cost:int = 10
@export var max_upgrade:int = 1
@export var current_upgrade_level:int = 0





func _ready() -> void:
	_init_upgrade()
	_update_bar()
	

func _on_pressed() -> void:
	if current_upgrade_level + 1 <= max_upgrade:
		if Score.can_pay(cost):
			_upgrade()
			_spawn_indicator()
			_update_bar()
			
			
			
func _spawn_indicator()->void:
	pass

func _init_upgrade()->void:
	if name in Upgrade.upgrade_dict:
		current_upgrade_level = Upgrade.get_upgrade(name)
	else:
		Upgrade.upgrade_dict[name] = 0
	
	

		
		
func _upgrade()->void:
	pass


func _add_point()->void:
	current_upgrade_level += 1
	Upgrade._set_upgrade(name,current_upgrade_level)
	
	
func can_buy()->bool:
	return Score.can_pay(cost)

func _update_bar()->void:
	$ProgressBar.max_value = max_upgrade
	$ProgressBar.value = current_upgrade_level
