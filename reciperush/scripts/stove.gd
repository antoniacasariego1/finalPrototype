extends Area2D

var interactable := false

func set_interactable(value: bool):
	interactable = value
	print("set_interactable called. Stove is now interactable:", interactable)

func _on_body_entered(body):
	print("body_entered triggered by:", body.name)
	if interactable and body.name == "Player":
		print("Stove is interactable and Player touched it.")
		start_cooking()
	else:
		print("Stove not interactable or wrong body touched.")

func start_cooking():
	interactable = false
	print("Cooking started.")
	if $Timer:
		$Timer.start()
		print("Timer started!")
	else:
		print("Timer not found, changing scene manually.")
		var scene_path = get_tree().current_scene.scene_file_path
		if scene_path.find("level_one") != -1:
			get_tree().change_scene_to_file("res://scenes/level_two.tscn")
		elif scene_path.find("level_two") != -1:
			get_tree().change_scene_to_file("res://scenes/level_three.tscn")
		elif scene_path.find("level_three") != -1:
			get_tree().change_scene_to_file("res://scenes/win.tscn")
		

func _on_timer_timeout():
	print("Timer finished. Changing level...")
	var scene_path = get_tree().current_scene.scene_file_path
	if scene_path.find("level_one") != -1:
		get_tree().change_scene_to_file("res://scenes/level_two.tscn")
	elif scene_path.find("level_two") != -1:
		get_tree().change_scene_to_file("res://scenes/level_three.tscn")
	elif scene_path.find("level_three") != -1:
		get_tree().change_scene_to_file("res://scenes/win.tscn")
