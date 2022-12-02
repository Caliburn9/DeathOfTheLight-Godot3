extends KinematicBody2D

const ACCELERATION = 400
const MAX_SPEED = 50
const FRICTION = 500

enum {
	MOVE,
	ATTACK
}

export var attack_delay = 0.25

var state = MOVE
var item = null
var holding_item = false
var can_attack = true
var velocity = Vector2.ZERO
var attack_vector = Vector2.ZERO
var attackTimer = null
var near_pedestal = false

signal dead
signal win
signal orb_interaction
#signal interacted_with_orb(value)

onready var itemDetector = $ItemDetector
onready var itemSlot = $ItemSlot
onready var weaponAttackPos = $WeaponAttackPos
onready var hurtbox = $Hurtbox
onready var stats = $Stats

func _ready():
	attackTimer = Timer.new()
	attackTimer.one_shot = true
	attackTimer.set_wait_time(attack_delay)
	attackTimer.connect("timeout", self, "on_AttackTimer_timeout")
	add_child(attackTimer)

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
	
		ATTACK:
			attack_state(attack_vector)

func pick_up_item():
	#remember what item was deleted
	var _item = itemDetector.return_item()
	item = _item
	
	#delete the item in the level
	_item.get_parent().call_deferred("remove_child", _item)
	
	#add item to player tree
	self.call_deferred("add_child", item)
	item.position = itemSlot.position
	
	#disable item collision shape
	item.disable_collision_shape()
	
	#fill "inventory"
	holding_item = true

func drop_item():
	#delete item from player tree
	self.call_deferred("remove_child", item)
	
	#add item to world tree
	var world = self.get_parent()
	world.call_deferred("add_child", item)
	item.position = position + Vector2(0, 8)
	
	#enable item collision shape
	item.enable_collision_shape()
	
	#empty inventory
	holding_item = false

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()
	
	if itemDetector.item_detected():
		if Input.is_action_just_pressed("interact"):
			if holding_item == false:
				pick_up_item()
				print("Picking up")
				if item.get_item_type() == "Orb":
					emit_signal("orb_interaction")
#					emit_signal("interacted_with_orb", 3.75)
#					item.change_is_picked_up()
			else:
				drop_item()
				print("Dropping")
				if item.get_item_type() == "Orb":
					emit_signal("orb_interaction")
#					emit_signal("interacted_with_orb", 2.25)
#					item.change_is_picked_up()
	
	if Input.is_action_just_pressed("use"):
		if holding_item:
			match item.get_item_type():
				"Orb":
					print("Holding Orb")
					#Place orb on pedestal if near it
					if near_pedestal == true:
					#Trigger win condition
						emit_signal("win")
				
				"Weapon":
					if can_attack:
						print("Holding Weapon")
						#Set state to attack
						state = ATTACK
						#Pass necessary attacking logic
						attack_vector = input_vector

func attack_state(atk_vec):
	#stop moving and set can attack to false
	velocity = Vector2.ZERO
	can_attack = false
	
	#move weapon based on facing dir
	#and rotate accordingly
	#(1, 0) or (1,1)
	if atk_vec == Vector2.RIGHT or atk_vec >= (Vector2.ONE/2):
		weaponAttackPos.rotation_degrees = 0
		weaponAttackPos.global_position = global_position + Vector2(8,0)
	#(-1,0) or (-1,-1)
	elif atk_vec == Vector2.LEFT or atk_vec <= (-Vector2.ONE/2):
		weaponAttackPos.rotation_degrees = 180
		weaponAttackPos.global_position = global_position + Vector2(-8,0)
	#(0,1)
	elif atk_vec == Vector2.DOWN:
		weaponAttackPos.rotation_degrees = 90
		weaponAttackPos.global_position = global_position + Vector2(0,8)
	#(0,-1)
	elif atk_vec == Vector2.UP:
		weaponAttackPos.rotation_degrees = 270
		weaponAttackPos.global_position = global_position + Vector2(0,-8)
	
	item.position = weaponAttackPos.position
	item.rotation = weaponAttackPos.rotation
	
	#turn on weapon hitbox and 
	#set hitbox knockback vector
	item.enable_hitbox()
	item.set_hitbox_knockback_vector(atk_vec)
	
	#start timer
	if attackTimer.is_stopped():
		attackTimer.start()

func move():
	velocity = move_and_slide(velocity)

func is_near_pedestal(bool_val):
	near_pedestal = bool_val

func on_AttackTimer_timeout():
	print("Attack timer ended")
	
	#reduce weapon durability
	item.reduce_durability()
	
	#empty hand if weapon is destroyed
	if item.return_durability() <= 0:
		item = null
		holding_item = false

	#if weapon is not destroyed
	if item != null:
		#return weapon to original position 
		#and rotation
		item.position = itemSlot.position
		item.rotation = itemSlot.rotation
		#and turn off weapon hitbox
		item.disable_hitbox()
	
	#return to move state and set can attack
	#to true
	can_attack = true
	state = MOVE

func _on_Hurtbox_area_entered(area):
	#take damage something like below
	stats.health -= area.damage
	print("Player took damage")
	hurtbox.start_invul(.6)

func _on_Stats_no_health():
	queue_free()
	emit_signal("dead")
