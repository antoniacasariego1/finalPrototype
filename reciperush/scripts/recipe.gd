extends Area2D

signal recipe_picked_up

func _on_body_entered(body: Node):
	if body.name == "Player":
		recipe_picked_up.emit()
		queue_free()
