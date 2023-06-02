extends Area2D

export var damage = 1
export var canDamage = true;

onready var collisionShape = $CollisionShape2D

func disable_collision_shape():
	collisionShape.set_deferred("disabled", true)
