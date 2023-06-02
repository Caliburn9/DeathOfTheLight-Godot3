extends KinematicBody2D

enum {
	IDLE,
	CHASE
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

export var ACCELERATION = 300
export var MAX_SPEED = 35
export var FRICTION = 400

onready var state = IDLE

onready var sprite = $AnimatedSprite
onready var playerDetector = $PlayerDetector
onready var softCollision = $SoftCollision
onready var hurtbox = $Hurtbox
onready var hitbox = $Hitbox
onready var stats = $Stats
onready var itemDropper = $ItemDropper

#audio objects
onready var enemyHurtSound = $HurtSoundQueue
onready var enemyWalkSound = $WalkSoundQueue

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			
			if sprite != null:
				sprite.playing = false
				sprite.frame = 0
			
			seek_player()
		
		CHASE:
			var player = playerDetector.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
				enemyWalkSound.play_sound()
			else:
				state = IDLE
	
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 600
	
	velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta):
	var dir = global_position.direction_to(point)
	
	if sprite != null:
		if MAX_SPEED != 0:
			sprite.playing = true
		
		sprite.flip_h = velocity.x < 0
	
	velocity = velocity.move_toward(dir * MAX_SPEED, ACCELERATION * delta)

func seek_player():
	if playerDetector.can_see_player():
		state = CHASE

func set_max_speed(val):
	MAX_SPEED = val

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	
	if stats.health != 0:
		enemyHurtSound.play_sound()
	
	knockback = area.knockback_vector * 150
	hurtbox.start_invul(.4)
	hurtbox.create_hit_effect()

func _on_Stats_no_health():
	SoundManager.play_enemy_death_sound()
#	sprite.visible = false
#	hurtbox.start_invul(1)
#	hitbox.disable_collision_shape()
#	yield(SoundManager.get_child_from_name("EnemyDeathSoundQueue"), "finished")
	queue_free()
	itemDropper.drop_item()
