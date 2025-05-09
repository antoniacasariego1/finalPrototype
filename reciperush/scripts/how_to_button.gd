extends Area2D

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("Back button clicked!")
		get_tree().change_scene_to_file("res://scenes/how_to.tscn")  # Adjust the path!
