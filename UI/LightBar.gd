extends Control

onready var lightBarTexture = $TextureProgress
onready var timer = $Timer

signal no_light

export(float) var light_decay_time = 1
export var light_decay_value = 2
export var max_light_level = 20
export var light_value = 0

func _ready():
	lightBarTexture.max_value = max_light_level
	light_value = lightBarTexture.max_value
	lightBarTexture.value = light_value
	timer.set_wait_time(light_decay_time)

func _physics_process(delta):
	if light_value <= 0:
		emit_signal("no_light")

func change_light_decay_time(decay_value):
	light_decay_time = decay_value
	timer.set_wait_time(light_decay_time)	
	print("Decay Time is " + str(light_decay_time))

func _on_Timer_timeout():
	if lightBarTexture.value != 0:
		light_value -= light_decay_value
		lightBarTexture.value = light_value

func _on_Player_interacted_with_orb(value):
	change_light_decay_time(value)

func _on_LightOrb_increase_light_level(increment):
	if lightBarTexture.value < max_light_level:
		light_value += increment
		lightBarTexture.value = light_value
