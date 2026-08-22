extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.signal_score_changed.connect(_on_score_changed)
	_on_score_changed(GameManager.score)


func _on_score_changed(score: int):
	text = "Points: " + str(score)
