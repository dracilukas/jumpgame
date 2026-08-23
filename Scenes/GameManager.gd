extends Node

################################################
# LIVES
################################################
signal signal_lives_changed(lives: int)

const MAX_LIVES := 3

var lives: int = MAX_LIVES:
	set(value):
		lives = clamp(value, 0, MAX_LIVES)
		signal_lives_changed.emit(lives)

func reset_lives():
	lives = MAX_LIVES

################################################
# SCORE
################################################
signal signal_score_changed(score: int)

var score: int = 0:
	set(value):
		score = value
		signal_score_changed.emit(score)

func decrease_health():
	lives -= 1
	
func add_score_point(value :int = 1):
	print("Adding %d to %d" % [ value, score ])
	score += value
	
func reset_score():
	score = 0

################################################
# LEVELS
################################################
signal signal_game_over()
signal signal_level(level: PackedScene)
signal signal_main_menu()

func change_level(level: PackedScene):
	signal_level.emit(level)
	
func goto_main_menu():
	signal_main_menu.emit()
	

func goto_game_over():
	signal_game_over.emit()
