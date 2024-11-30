extends Control

@export var text_to_render:String
@export var shift:float = 0.1
@export var magnitude:int = 10
var list_of_child:Array[Label] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_init()
	$Timer.start(PI*2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_animation()

func _init()->void:
	for i:int in range(len(text_to_render)):
		var child:Label = Label.new()
		add_child(child)
		child.position.x = i*10
		child.text = text_to_render[i]

func _animation()->void:
	for i:int in range(len(text_to_render)):
		var child:Label = get_child(i+1)
		child.position.y = sin($Timer.time_left + i*shift)*2
