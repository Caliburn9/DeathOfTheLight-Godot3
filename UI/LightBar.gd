extends Control

onready var lightBarTexture = $TextureProgress
onready var timer = $Timer
onready var math = $Math

signal no_light
signal light_value_changed(change_amt_percent)

export(float) var light_timer = 1
export var light_decay_value = 2
export var light_increment_value = 2
export var max_light_level = 20
export var light_value = 0

var player_interacted_with_orb = false

func _ready():
	lightBarTexture.max_value = max_light_level
	light_value = lightBarTexture.max_value
	lightBarTexture.value = light_value
	timer.set_wait_time(light_timer)

func _physics_process(delta):
	if light_value <= 0:
		emit_signal("no_light")

func _on_Timer_timeout():
	var light_value_percentage = 0
	
	if player_interacted_with_orb:
		if lightBarTexture.value < max_light_level:
			light_value += light_increment_value
			lightBarTexture.value = light_value
			light_value_percentage = math.value_to_percentage(float(light_value), float(max_light_level))
			emit_signal("light_value_changed", light_value_percentage)
	else:
		if lightBarTexture.value != 0:
			light_value -= light_decay_value
			lightBarTexture.value = light_value
			light_value_percentage = math.value_to_percentage(float(light_value), float(max_light_level))
			emit_signal("light_value_changed", light_value_percentage)

func _on_Player_orb_interaction():
	player_interacted_with_orb = !player_interacted_with_orb
	if !player_interacted_with_orb:
		light_timer = .5
	else:
		light_timer = 1

#func change_light_decay_time(decay_value):
#	light_decay_time = decay_value
#	timer.set_wait_time(light_decay_time)
#	print("Decay Time is " + str(light_decay_time))

#func _on_Player_interacted_with_orb(value):
#	change_light_decay_time(value)
