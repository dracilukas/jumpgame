extends Panel

@onready var hearts: Array[Node] = $HBoxContainer.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.signal_lives_changed.connect(_on_lives_changed)
	_on_lives_changed(GameManager.lives)


func _on_lives_changed(lives: int):
	for i in range(hearts.size()):
		hearts[i].visible = i < lives
