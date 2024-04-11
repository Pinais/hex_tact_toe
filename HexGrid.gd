extends Node2D

@export var size : float = 100			#center to tip

var hex : PackedScene = preload("res://hex.tscn")

var origin : Vector2 = Vector2(0,0)
var outerR : float = 2 * size 			#tip to tip
var innerR : float = 1.7 * size 		#flat to flat
var orientation : String = "flat-top"
var outerOffset : float = (3 * size)/4
var innerOffset : float = 1.7 * size
var rowOffset : float = size
var grid : Array = []


# Called when the node enters the scene tree for the first time.
func _ready():
	global_position=origin
	var xMax = 4;
	var yMax = 2;
	for x in range(0,xMax):
		grid.append([])
		for y in range(0,yMax):
			var newHex = hex.instantiate()
			if ((x%2) == 0):
				newHex.initialize(Vector2(origin.x+x*outerR,origin.y+y*innerR), size)
			elif ((x%2)!=0):
				newHex.initialize(Vector2(origin.x+x*outerR,origin.y+y*innerR+rowOffset), size)
			add_child(newHex)
			grid[x].append(newHex)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
