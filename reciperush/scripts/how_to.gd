extends Node2D


func _on_back_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Back button clicked!")
		get_tree().change_scene_to_file("res://scenes/welcome_screen_workinh.tscn")  # Adjus
