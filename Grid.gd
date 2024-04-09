extends Node2D

@export var size : float = 100			#center to tip

var origin : Vector2 = Vector2(0,0)
var outerR : float = 2 * size 			#tip to tip
var innerR : float = 1.7 * size 		#flat to flat
var orientation : String = "flat-top"
var outerOffset : float = (3 * size)/4
var innerOffset : float = 1.7 * size


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
