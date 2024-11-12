extends UpgradeBase

@export_category("benefit related")
@export var related_var:Array[String] = []
@export var power_increase:Array[int] = []

func _upgrade()->void:
	_add_point()
	_add_power()



func _spawn_indicator()->void:
	var r:String = ""
	for variable:String in related_var:
		if "_" in variable:
			for i:String in variable.split("_",false,-1):
				r += i
		else:
			r = variable
		
		var child:UpgradePrefab = load("res://component/other/prefab/upgrade_prefab.tscn").instantiate()
		add_child(child)
		child._set_text("+ " + r)
		


func _add_power()->void:
	for i in range(len(related_var)):
		PlayerStats._add(related_var[i],power_increase[i])
