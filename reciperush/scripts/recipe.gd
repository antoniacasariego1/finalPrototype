extends Area2D
signal recipe_picked_up

func _on_body_entered(body: Node):
	print("something touched me:", body.name)
	if body.name == "Player":
		print("Player touched recipe!")
		recipe_picked_up.emit()
		queue_free()
