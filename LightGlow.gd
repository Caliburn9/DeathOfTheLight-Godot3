extends Light2D

onready var math = $Math

export(float) var start_scale = 0

var min_texture_scale = 0.5
var max_texture_scale = 2
var scale_rate = 0.2

func _ready():
	texture_scale = start_scale

func return_min_texture_scale():
	return min_texture_scale

func return_max_texture_scale():
	return max_texture_scale

func change_texture_scale(result_scale):
	texture_scale = lerp(texture_scale, result_scale, scale_rate)
	set_texture_scale(texture_scale)

#var result_scale = 0
#
#func decrease_scale():
#	result_scale = lerp(result_scale, min_texture_scale, scale_rate)
#	set_texture_scale(result_scale)

#func _physics_process(delta):
#	decrease_scale()
##	set_texture_scale(result_scale)
