extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var body_scene = preload("res://body_gravity.tscn")
onready var arrow_tex = preload("res://arrow.png")

var tracked_nodes = []
var arrows = []

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.zen:
		$hud/time.visible = false
		$hud/score_label.visible = false
		$timeleft.stop()
	spawn_body()
	spawn_body()
	spawn_body()
	spawn_body()
	spawn_body()
	randomize()

func spawn_body():
	var the_body = body_scene.instance()
	the_body.position.y = 0
	the_body.position.x = (randi() % 2859) - 1000
	the_body.connect("died", self, "_on_body_died")
	the_body.connect("screen_exited", self, "_on_body_screen_exit")
	the_body.connect("screen_entered", self, "_on_body_screen_enter")
	if not the_body.get_node("VisibilityNotifier2D").is_on_screen():
		tracked_nodes.append(the_body)
	add_child(the_body)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for node in arrows:
		if !node.get_ref():
			continue
		node.get_ref().queue_free()
	arrows = []
	for body in tracked_nodes:
		var arrow = TextureRect.new()
		arrow.rect_size = Vector2(40, 40)
		arrow.texture = arrow_tex
		if body.position.direction_to($fish.position).x < 0:
			arrow.flip_h = true
		arrows.append(weakref(arrow))
		$hud.get_node(str(int(arrow.flip_h))).add_child(arrow)
	$hud.get_node("time").text = str(int($timeleft.time_left))
	$hud.get_node("score_label").text = "Score: " + str(Global.score)
	pass

func _on_body_died(body):
	tracked_nodes.remove(tracked_nodes.find(body))
	spawn_body()
	
func _on_body_screen_exit(body):
	tracked_nodes.append(body)
	pass

func _on_body_screen_enter(body):
	tracked_nodes.remove(tracked_nodes.find(body))
	pass


func _on_timeleft_timeout():
	get_tree().change_scene("res://gameover.tscn")
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	if (sign($fish/Camera2D.position.direction_to($fish.position).x) == -1):
		$hud/leftremind.visible = true
	else:
		$hud/rightremind.visible = true
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_entered():
	$hud/leftremind.visible = false
	$hud/rightremind.visible = false
	pass # Replace with function body.
