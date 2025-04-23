extends Node2D

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("Clicked!")
		get_tree().change_scene_to_file("res://scenes/level_one.tscn")

func _on_area_2d_mouse_entered():
	print("Hovered over!")

func _on_area_2d_mouse_exited():
	print("Mouse exited!")
