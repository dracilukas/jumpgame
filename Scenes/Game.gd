extends Node2D

@export var initial_level: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.signal_level.connect(load_level)
	GameManager.signal_main_menu.connect(load_main_menu)
	load_main_menu()
	GameManager.signal_lives_changed.connect(_on_lives_changed)

func load_level(level_scene: PackedScene):
	print("Changing level to %s" % level_scene)
	for child in $Level.get_children():
		child.queue_free()

	var level = level_scene.instantiate()
	$Level.add_child(level)

func load_main_menu():
	GameManager.change_level(initial_level)
	GameManager.reset_lives()
	GameManager.reset_score()
	
func _on_lives_changed(lives: int):
	if lives < 1:
		GameManager.change_level(preload ("res://Scenes/Levels/final_score.tscn"))
