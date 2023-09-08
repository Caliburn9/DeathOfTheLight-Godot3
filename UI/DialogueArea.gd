extends Area2D

export var dialogue_key = ""
# chance from 1 to 10 (1 highest amount; 10 lowest amount)
export (float) var dialogue_display_chance = 0
var randomizer = RandomNumberGenerator.new()

func _ready():
	randomizer = RandomNumberGenerator.new()

func _on_DialogueArea_area_entered(area):
	var chance = randomizer.randf_range(1, dialogue_display_chance)
	if dialogue_display_chance == chance:
		DialogueSignalBus.emit_signal("display_dialogue", dialogue_key)
