extends Control

var durability = 1 setget set_durability
var max_durability = 1 setget set_max_durability

onready var IconTexture = $IconTexture

func set_durability(value):
	durability = clamp(value, 0, max_durability)
	if IconTexture != null:
		IconTexture.rect_size.x = durability * 5

func set_max_durability(value):
	max_durability = max(value, 1)
	self.durability = min(durability, max_durability)

func _ready():
	self.max_durability = get_parent().max_durability
	self.durability = get_parent().durability
	get_parent().connect("durability_changed", self, "set_durability")
	get_parent().connect("max_durability_changed", self, "set_max_durability")
