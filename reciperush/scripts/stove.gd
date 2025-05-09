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
		get_tree().change_scene_to_file("res://scenes/level_two.tscn")

func _on_timer_timeout():
	print("Timer finished. Changing scene to Level 2...")
	get_tree().change_scene_to_file("res://scenes/level_two.tscn")
