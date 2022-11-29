extends CanvasLayer

onready var pause = $Pause
onready var death = $Death
onready var win = $Win

var lost = false
var won = false

func _ready():
	set_visible(false, pause)
	set_visible(false, death)
	set_visible(false, win)

func _input(event):
	if event.is_action_pressed("pause"):
		if !lost && !won:
			set_visible(!get_tree().paused, pause)
			get_tree().paused = !get_tree().paused
		else:
			get_tree().reload_current_scene()
			get_tree().paused = !get_tree().paused

func set_visible(is_visible, control_ui):
	for node in control_ui.get_children():
		node.visible = is_visible

func _on_Player_dead():
	game_lost()

func _on_LightBar_no_light():
	game_lost()

func _on_Player_win():
	game_win()

func game_lost():
	lost = true
	set_visible(!get_tree().paused, death)
	get_tree().paused = !get_tree().paused

func game_win():
	won = true
	set_visible(!get_tree().paused, win)
	get_tree().paused = !get_tree().paused

