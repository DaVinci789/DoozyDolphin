extends RigidBody2D
signal died
signal screen_exited
signal screen_entered
var is_dead := false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y > 1000: # death zone
		is_dead = true
	pass


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("screen_exited", self)
	if not is_dead:
		return
	emit_signal("died", self)
	$CollisionShape2D.disabled = true
	queue_free()
	Global.score += 1
	pass # Replace with function body.


func _on_body_body_died():
	is_dead = true
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_entered():
	emit_signal("screen_entered", self)
	pass # Replace with function body.
