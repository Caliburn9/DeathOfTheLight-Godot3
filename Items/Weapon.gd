extends "res://Items/Item.gd"

export var durability = 1

onready var hitbox = $Hitbox
onready var hitboxColShape = $Hitbox/CollisionShape2D

func _ready():
	disable_hitbox()

func _physics_process(delta):
	destroy_weapon()

func reduce_durability():
	durability -= 1

func destroy_weapon():
	if durability <= 0:
		queue_free()

func return_durability():
	return durability

func disable_hitbox():
	hitboxColShape.set_deferred("disabled", true)

func enable_hitbox():
	hitboxColShape.set_deferred("disabled", false)

func set_hitbox_knockback_vector(value):
	hitbox.knockback_vector = value
