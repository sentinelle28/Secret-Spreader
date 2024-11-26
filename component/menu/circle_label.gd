@tool
extends Node2D

@export var background_color:Color
@export var color:Color
@export var radius:int = 10

# Called when the node enters the scene tree for the first time.
func _draw() -> void:
	draw_circle(Vector2.ZERO,radius,background_color,true)
	draw_arc(Vector2.ZERO,radius,0,2*PI,1000,color,radius/2)
