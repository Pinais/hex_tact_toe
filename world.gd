extends Node2D


@onready var mainCamera : Camera2D = $Camera2D

var cameraSpeed = Vector2(300, 300)


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mainCamera.global_position.x += cameraSpeed.x * delta * (int(Input.is_action_pressed("moveCameraRight")) - int(Input.is_action_pressed("moveCameraLeft")))
	mainCamera.global_position.y += cameraSpeed.y * delta * (int(Input.is_action_pressed("moveCameraDown")) - int(Input.is_action_pressed("moveCameraUp")))
