extends CanvasLayer

func toggle_pause():
	get_tree().paused = !get_tree().paused
	self.visible = get_tree().paused

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()

func _on_resume_pressed():
	toggle_pause()

func _on_menu_pressed() -> void:
	GameManager.goto_main_menu()
	toggle_pause()
