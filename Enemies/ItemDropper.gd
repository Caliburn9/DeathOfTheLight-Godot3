extends Node2D

export(int) var drop_range = 8

var drop_randomizer = RandomNumberGenerator.new()
var drop_vector = Vector2.ZERO

##Items list
#onready var soul = preload("res://Items/Soul.tscn")
onready var sword = preload("res://Items/Sword.tscn")
onready var axe = preload("res://Items/Axe.tscn")
onready var spear = preload("res://Items/Spear.tscn")

func drop_item():
	drop_randomizer.randomize()
#	var drop_amount = drop_randomizer.randi_range(3, 7)
	var weapon_drop_chance = drop_randomizer.randi_range(1, 100)
	print("Drop Item Function Called")
	
#	for i in range(drop_amount):
#		var soul_instance = soul.instance()
#		#get_tree().get_root().call_deferred("add_child", soul_instance)
#		get_parent().get_parent().call_deferred("add_child", soul_instance)
#		drop_vector = Vector2(rand_range(drop_range, -drop_range), rand_range(drop_range, -drop_range))
#		soul_instance.global_position = global_position + drop_vector
#		print("Dropped Soul")
	
	if weapon_drop_chance <= 100 and weapon_drop_chance > 50:
		var sword_instance = sword.instance()
		#get_tree().get_root().call_deferred("add_child", sword_instance)
		get_parent().get_parent().call_deferred("add_child", sword_instance)
		sword_instance.global_position = global_position
		print("Dropped Sword")
	elif weapon_drop_chance <= 50 and weapon_drop_chance > 15:
		var axe_instance = axe.instance()
		#get_tree().get_root().call_deferred("add_child", sword_instance)
		get_parent().get_parent().call_deferred("add_child", axe_instance)
		axe_instance.global_position = global_position
		print("Dropped Axe")
	elif weapon_drop_chance <= 15 and weapon_drop_chance > 0:
		var spear_instance = spear.instance()
		#get_tree().get_root().call_deferred("add_child", sword_instance)
		get_parent().get_parent().call_deferred("add_child", spear_instance)
		spear_instance.global_position = global_position
		print("Dropped Spear")
