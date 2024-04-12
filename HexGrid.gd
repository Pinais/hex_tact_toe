extends Node2D

@export var radius : float = 100			#center to tip
@export var xMax : int = 4				#max amount of hexes in a row
@export var yMax : int = 4				#max amount of rows
@export var origin : Vector2 = Vector2(0,0)

var hex : PackedScene = preload("res://Hex.tscn")

var t2t : float = 2 * radius 			#tip to tip
var f2f : float = 1.73 * radius 		#flat to flat
var orientation : String = "flat-top"
var t2tOffset : float = 0.75 * t2t 
var f2fOffset : float = f2f
var rowOffset : float = f2f/2
var grid : Array = []


# Called when the node enters the scene tree for the first time.
func _ready():
	create_grid(xMax, yMax)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func create_grid(_xMax : int, _yMax : int):
	global_position = origin
	for x in range(0,xMax):
		grid.append([])
		for y in range(0,yMax):
			var newHex = hex.instantiate()
			if ((x%2) == 0):
				newHex.position = Vector2(x*t2tOffset,y*f2fOffset)
			elif ((x%2)!=0):
				newHex.position = Vector2(x*t2tOffset,y*f2fOffset+rowOffset)
			add_child(newHex)
			grid[x].append(newHex)
