extends Node2D


@export var camera : Camera2D
@export var hexGrid : Node2D

var direction : Vector2 = Vector2.ZERO
var last_direction : Vector2 = Vector2.ZERO
var control_is_pressed : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not control_is_pressed:
		direction.x = (int(Input.is_action_pressed ("moveCameraRight")) - int(Input.is_action_pressed("moveCameraLeft")))
		direction.y = (int(Input.is_action_pressed("moveCameraDown")) - int(Input.is_action_pressed("moveCameraUp")))
		if(direction != Vector2.ZERO or last_direction != Vector2.ZERO):
			camera.move(direction, delta)
			last_direction = direction



func _unhandled_input(event):
	if event.is_action_pressed("control"):
		control_is_pressed = true
	elif event.is_action_released("control"):
		control_is_pressed = false
	if event.is_action_pressed("select"):
		hexGrid.select_hex_at(get_global_mouse_position())
	if control_is_pressed: 
		if event.is_action_pressed("disableHex"):
			hexGrid.disable_selected()
		if event.is_action_pressed("enableHex"):
			hexGrid.enable_selected()
