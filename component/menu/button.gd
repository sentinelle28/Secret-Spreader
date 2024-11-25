@tool
extends Node2D

@export var color:Color
@export var radius:int = 10
@export var text_label:String
@export var path:String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_up_button()
	$Label.text = text_label

func _set_up_button()->void:
	$Button.set_size(Vector2(radius*2,radius*2))
	$Button.set_position(Vector2(-radius,-radius))

func _draw() -> void:
	draw_circle(Vector2.ZERO,radius,Color.GRAY,true)
	draw_arc(Vector2.ZERO,radius,0,2*PI,1000,color,radius/2)
	


func _on_button_pressed() -> void:
	SceneTransition._change_scene(path)
