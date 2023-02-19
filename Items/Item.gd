extends Area2D

export var item_type = "Item"

onready var colShape = $CollisionShape2D
onready var sprite = $Sprite

func _ready():
	enable_collision_shape()

func get_item_type():
	return item_type

func disable_collision_shape():
	colShape.set_deferred("disable", true)

func enable_collision_shape():
	colShape.set_deferred("disable", false)
