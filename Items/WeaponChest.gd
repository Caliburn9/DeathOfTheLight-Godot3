extends "res://Items/Item.gd"

export(int) var drop_range = 4

var drop_randomizer = RandomNumberGenerator.new()
var drop_vector = Vector2.ZERO

onready var brk_sword = preload("res://Items/BrokenSword.tscn")
onready var sword = preload("res://Items/Sword.tscn")
onready var axe = preload("res://Items/Axe.tscn")
onready var spear = preload("res://Items/Spear.tscn")

func drop_weapon():
	drop_randomizer.randomize()
	var weapon_drop_chance = drop_randomizer.randi_range(1, 100)
	#print("Drop Weapon Function Called")
	
	if weapon_drop_chance <= 100 and weapon_drop_chance > 50:
		var brk_sword_instance = brk_sword.instance()
		get_parent().get_parent().call_deferred("add_child", brk_sword_instance)
		brk_sword_instance.global_position = global_position
		#print("Weapon Chest dropped Broken Sword")
	elif weapon_drop_chance <= 50 and weapon_drop_chance > 30:
		var sword_instance = sword.instance()
		get_parent().get_parent().call_deferred("add_child", sword_instance)
		sword_instance.global_position = global_position
		#print("Weapon Chest dropped Sword")
	elif weapon_drop_chance <= 30 and weapon_drop_chance > 15:
		var axe_instance = axe.instance()
		get_parent().get_parent().call_deferred("add_child", axe_instance)
		axe_instance.global_position = global_position
		#print("Weapon Chest dropped Axe")
	elif weapon_drop_chance <= 15 and weapon_drop_chance > 0:
		var spear_instance = spear.instance()
		get_parent().get_parent().call_deferred("add_child", spear_instance)
		spear_instance.global_position = global_position
		#print("Weapon Chest dropped Spear")
	
	queue_free()
