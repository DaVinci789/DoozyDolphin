extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var instruction := [
	"Hello and welcome to the island of Vandhackia!",
	"You are AZURE the dolphin and these nasty SURFERS have inflitrated your beautiful island!",
	"Your goal is to JUMP out of the water and SMACK those SURFERS back to where they came from!",
	"Use W and D to move LEFT and RIGHT",
	"Use S to DIVE. When released, you will JUMP out of the water!",
	"However, when out of the water, Azure will FLOP around in the air. You can't control their movement in the air!",
	"If you FLOP onto a SURFER, you SMACK them, knocking them out of the world because the developer thought the bug was funny.",
	"For every SURFER you SMACK, you gain one POINT. Then another SURFER SPAWNS.",
	"You can also press SPACE to get a small horizontal SPEED BOOST.",
	"Gain the most points before the time ends!",
	"Or play ZEN MODE with no points or time limit. Just infinite smacking!",
	"Once you're done playing around in ZEN MODE, press ESCAPE to open the PAUSE MENU and return to the MAIN MENU."
]

var current := 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/Label.text = instruction[0]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Global.tutorial:
		return
	if not Input.is_action_just_pressed("continue"):
		return
	
	current += 1
	if current >= instruction.size():
		visible = false
		return
	
	$Panel/Label.text = instruction[current]
	pass
