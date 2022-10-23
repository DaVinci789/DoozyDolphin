extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.zen = false
	Global.tutorial = false
	if Global.high_score > 0:
		$Label2.text = "Game by DaVinci789\nYour High Score: " + str(Global.high_score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://world.tscn")
	pass # Replace with function body.


func _on_Button2_pressed():
	get_tree().change_scene("res://world.tscn")
	Global.zen = true
	pass # Replace with function body.


func _on_Button3_pressed():
	get_tree().change_scene("res://world.tscn")
	Global.zen = true
	Global.tutorial = true
	pass # Replace with function body.
