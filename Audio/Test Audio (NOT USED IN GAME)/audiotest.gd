extends Node2D

func _input(event):
	if event.is_action_pressed("interact"):
		#$SoundPool.play_random_sound()
		$SoundQueue.play_sound()

func _on_HSlider_value_changed(value):
	$SoundQueue/AudioStreamPlayer.pitch_scale = value
