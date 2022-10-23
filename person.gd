extends KinematicBody2D
signal body_died

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var parent = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	if parent != null and parent.get_class() == "RigidBody2D":
		parent.connect("body_entered", self, "_on_parent_body_entered")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position = get_global_mouse_position()
	pass

func _on_parent_body_entered(node):
	if node.name != "fish":
		return
	emit_signal("body_died")
	parent.gravity_scale = 64
