extends Node

#everytime u add a sound queue or sound pool
#create a custom variable and function for it
#
#           -example-
#onready var fireballSoundQueue = $FireballSoundQueue
#
#func play_fireball_sound():
#	fireballSoundQueue.play_sound()

onready var enemyDeathSound = $EnemyDeathSoundQueue
onready var menuSelectSound = $MenuSelectSoundQueue
onready var menuConfirmSound = $MenuConfirmSoundQueue
onready var pauseSound = $PauseSoundQueue
onready var weaponBreakSound = $WeaponBreakSoundQueue
onready var lowLightSound = $LowLightBGM
onready var gameWinSound = $GameWinSoundQueue
onready var gameOverSound = $GameOverSoundQueue

onready var levelBGM = $LevelBGM
onready var mainMenuBGM = $MainMenuBGM

#either "MainMenu" or "Level"
var level = "MainMenu"

func _physics_process(delta):
	if level == "MainMenu":
		mainMenuBGM.play_sound()
		levelBGM.stop_sound()
	elif level == "Level":
		mainMenuBGM.stop_sound()
		levelBGM.play_sound()

func specify_level(_level):
	level = _level

func get_child_from_name(name):
	return get_node(name + "/AudioStreamPlayer")

func play_enemy_death_sound():
	enemyDeathSound.play_sound()

func play_menu_select_sound():
	menuSelectSound.play_sound()

func play_menu_confirm_sound():
	menuConfirmSound.play_sound()

func play_pause_sound():
	pauseSound.play_sound()

func play_weapon_break_sound():
	weaponBreakSound.play_sound()

func play_low_light_sound():
	lowLightSound.play_sound()

func stop_low_light_sound():
	lowLightSound.stop_sound()

func play_game_win_sound():
	gameWinSound.play_sound()

func play_game_over_sound():
	gameOverSound.play_sound()
