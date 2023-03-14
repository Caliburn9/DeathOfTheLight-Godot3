extends CanvasLayer

onready var pause = $Pause
onready var death = $Death
onready var win = $Win
onready var result = $Result

export(String, FILE) var NEXT_LEVEL: String = ""

var lost = false
var won = false

var total_enemies = 0
var remaining_enemies = 0 

func _ready():
	total_enemies = get_tree().get_nodes_in_group("Enemy").size()
	
	set_visible(false, pause)
	set_visible(false, death)
	set_visible(false, win)

func _input(event):
	if event.is_action_pressed("pause"):
		if lost:
			#reload current level
			get_tree().reload_current_scene()
			get_tree().paused = false
		elif won:
			#move to next level
			#or to a final game win screen
			if NEXT_LEVEL != "":
				get_tree().change_scene(NEXT_LEVEL)
				get_tree().paused = false
		else:
			#pause/unpause the game
			set_visible(!get_tree().paused, pause)
			get_tree().paused = !get_tree().paused
	
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused == true:
			get_tree().change_scene("res://Levels and Menus/MainMenu.tscn")
			get_tree().paused = false

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
	remaining_enemies = get_tree().get_nodes_in_group("Enemy").size()
	won = true
	
	set_visible(!get_tree().paused, win)
	win.write_results(remaining_enemies, total_enemies)
	get_tree().paused = !get_tree().paused

