extends Node2D

export(float, 0, 500, 20) var offset := 0.0 setget set_offset
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var fish := get_node("/root/world/fish")

func set_offset(_offset: float) -> void:
	offset = _offset

# Called when the node enters the scene tree for the first time.
func _ready():
	position = fish.position
	position.y += offset
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = fish.position.x
	pass
