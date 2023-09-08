extends Node2D

onready var dialogueArea = $DialogueArea/CollisionShape2D

func _ready():
	dialogueArea.disabled = true

func _physics_process(delta):
	dialogueArea.disabled = false
	yield(get_tree().create_timer(1), "timeout")
	queue_free()
