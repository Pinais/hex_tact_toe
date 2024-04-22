extends Node2D

@export var radius : float = 100		#center to tip
@export var xMax : int = 10				#max amount of hexes in a row
@export var yMax : int = 10				#max amount of rows
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
var selectedHex
var lastSelectedHex


func _ready():
	create_grid(xMax, yMax)


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
			newHex.label_hex(str(x,"/", y))
			grid[x].append(newHex)


func mouse_to_grid(mouse_pos : Vector2):
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
							return grid[x][y]
						elif abs_distance < closest_distance :
							closest_distance = abs_distance
							closest = grid[x][y]
							if x+1<xMax and closest_distance > abs(mouse_pos.distance_to(grid[x+1][y].global_position)):
								closest_distance = abs(mouse_pos.distance_to(grid[x+1][y].global_position))
								closest = grid[x+1][y]
							if y+1<yMax and closest_distance > abs(mouse_pos.distance_to(grid[x][y+1].global_position)):
								closest_distance = abs(mouse_pos.distance_to(grid[x][y+1].global_position))
								closest = grid[x][y+1]
							if x+1<xMax and y-1>0 and closest_distance > abs(mouse_pos.distance_to(grid[x+1][y-1].global_position)):
								closest_distance = abs(mouse_pos.distance_to(grid[x+1][y-1].global_position))
								closest = grid[x+1][y-1]
							if x+1<xMax and y+1<yMax and closest_distance > abs(mouse_pos.distance_to(grid[x+1][y+1].global_position)):
								closest_distance = abs(mouse_pos.distance_to(grid[x+1][y+1].global_position))
								closest = grid[x+1][y+1]
							return closest
			return null


func select_hex(incomingHex : Node2D):
	lastSelectedHex = selectedHex
	selectedHex = incomingHex
	
	var reselected_last_hex = lastSelectedHex is Node2D and selectedHex is Node2D and lastSelectedHex == selectedHex
	if reselected_last_hex:
		selectedHex = null
	
	if lastSelectedHex is Node2D:
		lastSelectedHex.modulate_current_color()
	if selectedHex is Node2D:
		selectedHex.modulate = Color.YELLOW

func select_hex_at(_pos : Vector2):
	var selected = mouse_to_grid(_pos)
	if(selected is Node2D):
		select_hex(selected)


func disable_selected():
	if selectedHex is Node2D:
		selectedHex.disable_hex()

func enable_selected():
	if selectedHex is Node2D:
		selectedHex.enable_hex()
