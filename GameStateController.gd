extends CanvasLayer

onready var pause = $Pause
onready var death = $Death
onready var win = $Win

export(String, FILE) var NEXT_LEVEL: String = ""
export var cur_level = "level"

var lost = false
var won = false

var total_enemies = 0
var remaining_enemies = 0 

func _ready():
	get_tree().paused = false
	total_enemies = get_tree().get_nodes_in_group("Enemy").size()
	
	set_visible(false, pause)
	set_visible(false, death)
	set_visible(false, win)

func _input(event):
	if event.is_action_pressed("pause"):
		SoundManager.play_pause_sound()
		
		if lost:
			#reload current level
			get_tree().paused = false
			get_tree().reload_current_scene()
		elif won:
			#move to next level
			#or to a final game win screen
			get_tree().paused = false
			
			if NEXT_LEVEL != "":
				SceneTransition.change_scene(NEXT_LEVEL)
				GlobalData.current_data[cur_level] = true
				GlobalData.sava_data(GlobalData.filePath)
				#print(GlobalData.current_data)
		else:
			#pause/unpause the game
			set_visible(!get_tree().paused, pause)
			get_tree().paused = !get_tree().paused
	
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused == true:
			get_tree().paused = false
			get_tree().reload_current_scene()
			SceneTransition.change_scene("res://Levels and Menus/MainMenu.tscn")

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
	#print("lost")
	
	SoundManager.play_game_over_sound()
	
	set_visible(!get_tree().paused, death)
	get_tree().paused = true

func game_win():
	remaining_enemies = get_tree().get_nodes_in_group("Enemy").size()
	won = true
	
	SoundManager.play_game_win_sound()
	
	set_visible(!get_tree().paused, win)
	win.write_results(remaining_enemies, total_enemies)
	get_tree().paused = true

