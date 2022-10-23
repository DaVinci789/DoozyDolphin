extends KinematicBody2D

enum FishState {
	SWIM,
	FLOP,
	JUMP,
	BREACH,
	BOUNCE,
}

var state: int = FishState.SWIM
var velocity := Vector2.ZERO
var target_position := Vector2.ZERO
var speed := 1000.0
var relaxed_length := 50.0
var tightness := 5.0
var spring_motion := Vector2.ZERO
var multiplier := 1.5

onready var follower := get_node("/root/world/follower")
onready var follower2 := get_node("/root/world/follower2")
onready var surface := get_node("/root/world/surface")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	target_position = follower.position
	
	if state != FishState.FLOP:
		if Input.is_action_pressed("left") && $boostcool.is_stopped():
			velocity = Vector2.LEFT * speed
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play()
		elif Input.is_action_pressed("right") && $boostcool.is_stopped():
			velocity = Vector2.RIGHT * speed
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play()
		else:
			$AnimatedSprite.stop()
		if Input.is_action_pressed("boost") && $boostcool.is_stopped():
			velocity.x *= 2.0
			$boostcool.start()
	
	match (state):
		FishState.SWIM:
			Global.label.text = "SWIM"
			var point_to_target := target_position - position
			if Input.is_action_pressed("down"):
				velocity.y = speed
				var length := point_to_target.length()
				var spring_force := (relaxed_length - length) * -tightness
				spring_motion = spring_force * point_to_target.normalized()
			else:

				var length := point_to_target.length()
				var spring_force := (relaxed_length - length) * -tightness
				spring_motion = spring_force * point_to_target.normalized()
			
			if Input.is_action_just_released("down"):
				spring_motion.y *= multiplier
				if (point_to_target.length() > 100):
					state = FishState.JUMP
		FishState.JUMP:
			Global.label.text = "JUMP"
			if position.y < surface.position.y:
				state = FishState.FLOP
				$AnimatedSprite.play("flop")
		FishState.FLOP:
			Global.label.text = "FLOP"
			if spring_motion.y < 0:
				spring_motion.y += 20
			else:
				spring_motion.y += 50
			
			var modifier := -1
			if $AnimatedSprite.flip_h:
				modifier = 1
			rotation_degrees += 2.0 * modifier
			if position.y > surface.position.y:
				state = FishState.BREACH
				rotation_degrees = 0
				$AnimatedSprite.play("default")
		FishState.BREACH:
			Global.label.text = "BREACH"
			if position.y > follower2.position.y:
				state = FishState.BOUNCE
				$floptime.start()
		FishState.BOUNCE:
			Global.label.text = "BOUNCE"
			var point_to_target := target_position - position
			var length := point_to_target.length()
			var spring_force := (relaxed_length - length) * -tightness
			spring_motion = spring_force * point_to_target.normalized()
	
	velocity.y += spring_motion.y
	Global.label.text = Global.label.text + " " + str(velocity)
	move_and_slide(velocity)
	velocity.y = 0
	if state == FishState.FLOP:
		velocity.x = lerp(velocity.x, 0, 0.005)
	else:
		velocity.x = lerp(velocity.x, 0, 0.01)
	pass


func _on_floptime_timeout():
	state = FishState.SWIM
	spring_motion = Vector2.ZERO
	pass # Replace with function body.
