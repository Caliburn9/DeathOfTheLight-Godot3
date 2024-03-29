extends "res://Items/Item.gd"

export var max_durability = 1
var durability = max_durability

signal durability_changed(value)
signal max_durability_changed(value)

onready var weaponbreakDialogue = preload("res://Items/WeaponBreakDialogue.tscn")
onready var hitbox = $Hitbox
onready var hitboxColShape = $Hitbox/CollisionShape2D

func _ready():
	self.durability = max_durability
	emit_signal("durability_changed", durability)
	disable_hitbox()

func _physics_process(delta):
	destroy_weapon()

func reduce_durability():
	durability -= 1
	emit_signal("durability_changed", durability)

func destroy_weapon():
	if durability <= 0:
		var weaponBreak = weaponbreakDialogue.instance()
		get_parent().get_parent().call_deferred("add_child", weaponBreak)
		weaponBreak.global_position = global_position
		queue_free()
		SoundManager.play_weapon_break_sound()

func return_durability():
	return durability

func disable_hitbox():
	hitboxColShape.set_deferred("disabled", true)

func enable_hitbox():
	hitboxColShape.set_deferred("disabled", false)

func set_hitbox_knockback_vector(value):
	hitbox.knockback_vector = value
