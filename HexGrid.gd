extends Node2D

@export var radius : float = 100		#center to tip
@export var xMax : int = 4				#max amount of hexes in a row
@export var yMax : int = 4				#max amount of rows
@export var origin : Vector2 = Vector2(0,0)

var hex : PackedScene = preload("res://Hex.tscn")

var t2t : float = 2 * radius 			#tip to tip
var f2f : float = 1.73 * radius 		#flat to flat
var c2f : float = 1.73 * radius * 0.5	#center to flat
var orientation : String = "flat-top"
var t2tOffset : float = 0.75 * t2t 
var f2fOffset : float = f2f
var rowOffset : float = f2f/2
var grid : Array = []
var gridStartX : float = origin.x - radius
var gridStartY : float = origin.y - rowOffset
var gridStart : Vector2 = Vector2(gridStartX, gridStartY)
var gridEndX : float = (xMax-1)*t2tOffset+radius
var gridEndY : float = (yMax-1)*f2fOffset+rowOffset*2
var gridEnd : Vector2 = Vector2(gridEndX, gridEndY)

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


func search_on_grid(mouse_pos : Vector2):
	if mouse_pos.x > gridStart.x && mouse_pos.y > gridStart.y:
		if mouse_pos.x < gridEnd.x && mouse_pos.y < gridEnd.y:
			var closest = null
			var closest_distance : float = 1000000.0
			var abs_distance : float
			for x in range(0,xMax):
				for y in range(0,yMax):
					abs_distance = abs(mouse_pos.distance_to(grid[x][y].global_position))
					if abs_distance < radius:
						if abs_distance < c2f:
							grid[x][y].modulate = Color.BLACK
							return grid[x][y]
						if abs_distance < closest_distance :
							closest_distance = abs_distance
							closest = grid[x][y]
			if closest != null:
				closest.modulate = Color.DARK_ORANGE
				return closest

func _unhandled_input(event):
	if event.is_action_pressed("selecionar"):
		search_on_grid(get_global_mouse_position())
