extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "GAME OVER\nYOUR SCORE WAS: " + str(Global.score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://world.tscn")
	Global.score = 0
	pass # Replace with function body.


func _on_Button2_pressed():
	get_tree().change_scene("res://mainmenu.tscn")
	Global.score = 0
	pass # Replace with function body.
