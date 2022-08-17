extends KinematicBody2D

export(int) var SPEED = 200
var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func movement():
	velocity = Vector2.ZERO
	velocity.x = Input.get_action_raw_strength("ui_right") - Input.get_action_raw_strength("ui_left")  
	velocity.y = Input.get_action_raw_strength("ui_down") - Input.get_action_raw_strength("ui_up") 
	velocity = velocity.normalized() * SPEED
	
	var mousePos = get_local_mouse_position().normalized()
	
	if velocity != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", mousePos)
		animationTree.set("parameters/Run/blend_position", mousePos)
		animationState.travel("Run")
	else:
		animationTree.set("parameters/Idle/blend_position", mousePos)
		animationState.travel("Idle")
	
func _physics_process(delta): #Godots FixedUpdate() function, _process is the Update() alternative.
	movement()
	velocity = move_and_slide(velocity)
