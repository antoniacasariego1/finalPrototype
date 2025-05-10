extends Node2D



func _on_play_again_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
		if event is InputEventMouseButton:
			print("Clicked with mouse")  # <--- this MUST show
			if event.pressed:
				print("Start button pressed!")
				get_tree().change_scene_to_file("res://scenes/welcome_screen_workinh.tscn")
