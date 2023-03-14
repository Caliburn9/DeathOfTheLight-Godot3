extends Control

onready var resultsLabel = $EnemyResults

func write_results(remaining, total):
	var num_slain = total - remaining
	resultsLabel.text = "You have slain " + str(num_slain) + " out of " + str(total) + " souls";

