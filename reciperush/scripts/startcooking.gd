
extends Node2D


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		print("Clicked!")
		get_tree().change_scene_to_file("res://scenes/level_one.tscn")
		
		

func _on_area_2d_mouse_entered():
	$Sprite2D.modulate = Color(1.2, 1.2, 1.2) # brighten

func _on_area_2d_mouse_exited():
	$Sprite2D.modulate = Color(1, 1, 1)
