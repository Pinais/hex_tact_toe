extends Camera2D


var cameraSpeed = Vector2(300, 300)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func move(direction:Vector2,delta:float):
	global_position.x += cameraSpeed.x * delta * direction.x
	global_position.y += cameraSpeed.y * delta * direction.y
