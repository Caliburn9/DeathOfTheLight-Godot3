extends Node

var filePath = "user://game_data.json"

var default_data = {
	"tutorial": false,
	"level1" : false,
	"level2" : false,
	"level3" : false,
	"current_level": "" 
}

var current_data = {}

func reset_data():
	#print("Data Reset")
	current_data.clear()
	current_data = default_data.duplicate(true)

func sava_data(path : String):
	#print("Data Saved")
	var file = File.new()
	file.open(path, File.WRITE)
	
	file.store_line(to_json(current_data))
	
	file.close()

func load_data(path : String):
	#print("Data Loaded")
	var file = File.new()
	file.open(path, File.READ)
	
	var data_json = JSON.parse(file.get_as_text())
	
	file.close()
	
	current_data = data_json.result
