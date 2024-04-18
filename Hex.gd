extends Node2D


@onready var poly : Polygon2D = $Polygon2D
@onready var insides : Polygon2D = $Polygon2DBorder
@onready var hexLabel : Label = $Label


@export_range(0.0, 1.0, 0.05) var insidesScale : float = 0.1
@export var IsOutsideVisible : bool = false


var radius : float = 100			#center to tip distance
var t2t : float = radius * 2		#tip to tip distance
var f2f : float = radius * 1.73	#flat to flat distance

var corners : PackedVector2Array = [Vector2(-radius,0), Vector2(-t2t*0.25,-f2f*0.5),
									Vector2(t2t*0.25,-f2f*0.5), Vector2(radius,0), 
									Vector2(t2t*0.25,f2f*0.5),Vector2(-t2t*0.25,f2f*0.5)]

# Called when the node enters the scene tree for the first time.
func _ready():
	poly.polygon = corners
	insides.polygon = corners
	poly.visible = IsOutsideVisible
	insides.scale = Vector2(insidesScale, insidesScale)


func label_hex(text : String):
	hexLabel.text = text
