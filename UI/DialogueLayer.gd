extends Node2D

export (String, FILE, "*json") var scene_text_file

var scene_text = []
var selected_text = []
var in_progress = false
var key = ""
var initial_time = 1
var regular_time = 4
var typing_speed = 0.1
var current_char = 0
var current_line = ""

onready var label = $RichTextLabel
onready var linetimer = $LineTimer
onready var texttimer = $TextTimer

func _ready():
	label.bbcode_text = "[center]"
	scene_text = load_scene_text()
	DialogueSignalBus.connect("display_dialogue", self, "on_display_dialogue")
	current_char = 0
	current_line = ""

func load_scene_text():
	var f = File.new()
	if f.file_exists(scene_text_file):
		f.open(scene_text_file, File.READ)
		return parse_json(f.get_as_text())

func on_display_dialogue(text_key):
	key = text_key
	linetimer.start(initial_time)

func _on_LineTimer_timeout():
	if in_progress:
		next_line()
	else:
		in_progress = true
		selected_text = scene_text[key].duplicate()
		show_text()
		linetimer.start(regular_time)

func next_line():
	if selected_text.size() > 0:
		show_text()
		linetimer.start(regular_time)
	else:
		finish()

func show_text():
	current_char = 0
	current_line = selected_text.pop_front()
	label.bbcode_text = "[center]" 
	texttimer.set_wait_time(typing_speed)
	texttimer.start()

func finish():
	label.bbcode_text = "[center]"
	in_progress = false

func _on_TextTimer_timeout():
	if current_char < len(current_line):
		var next_char = current_line[current_char]
		label.bbcode_text += next_char
		current_char += 1
	else:
		texttimer.stop()
