extends Node2D

#> List of items and weapons X
#> Get enemy type X
#> Each element of the list has its own drop chance 
#	based on enemy type
#> Items will drop on enemy death

export(int) var drop_range = 8

export var enemy_type = "Null" 

var randomizer = RandomNumberGenerator.new()
var drop_vector = Vector2.ZERO

#Items list
onready var sword = preload("res://Items/Sword.tscn")
onready var axe = preload("res://Items/Axe.tscn")
onready var spear = preload("res://Items/Spear.tscn")
onready var enemyStasis = preload("res://Items/EnemyStasis.tscn")
onready var weaponChest = preload("res://Items/WeaponChest.tscn")

#Drop chances
var sword_drop_chance = 0
var axe_drop_chance = 0
var spear_drop_chance = 0
var enemyStasis_drop_chance = 0
var weaponChest_drop_chance = 0

#Sets item drop chance based on enemy type
func set_drop_chance():
	match enemy_type:
		#Basic enemy
		"Enemy1":
			sword_drop_chance = 1
			axe_drop_chance = 1
		
		#Large enemy
		"Enemy2":
			spear_drop_chance = 1
			enemyStasis_drop_chance = 1
		
		#Small enemy
		"Enemy3":
			spear_drop_chance = 1
			weaponChest_drop_chance = 1
		
		"Null":
			pass
			#print("ItemDropper.gd: Enemy type not set!")

#Drop item(s)
func drop_item():
	set_drop_chance()
	randomizer.randomize()
	
	var item_drop_chance = randomizer.randi_range(1, 100)
	#print("Drop Item Function Called")
	
	if sword_drop_chance == 1:
		if item_drop_chance > 50 and item_drop_chance <= 100:
			var sword_instance = sword.instance()
			get_parent().get_parent().call_deferred("add_child", sword_instance)
			sword_instance.global_position = global_position
			#print("Dropped Sword")
	
	if axe_drop_chance == 1:
		if item_drop_chance > 20 and item_drop_chance <= 50:
			var axe_instance = axe.instance()
			get_parent().get_parent().call_deferred("add_child", axe_instance)
			axe_instance.global_position = global_position
			#print("Dropped Axe")
	
	if spear_drop_chance == 1:
		if item_drop_chance > 15 and item_drop_chance <= 30:
			var spear_instance = spear.instance()
			get_parent().get_parent().call_deferred("add_child", spear_instance)
			spear_instance.global_position = global_position
			#print("Dropped Spear")
	
	if enemyStasis_drop_chance == 1:
		if item_drop_chance > 0 and item_drop_chance <= 15:
			var enemyStasis_instance = enemyStasis.instance()
			get_parent().get_parent().call_deferred("add_child", enemyStasis_instance)
			enemyStasis_instance.global_position = global_position
			#print("Dropped Enemy Stasis")
	
	if weaponChest_drop_chance == 1:
		if item_drop_chance > 50 and item_drop_chance <= 100:
			var weaponChest_instance = weaponChest.instance()
			get_parent().get_parent().call_deferred("add_child", weaponChest_instance)
			weaponChest_instance.global_position = global_position
			#print("Dropped Weapon Chest")
