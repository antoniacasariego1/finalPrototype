extends Area2D

@export var ingredient_name: String = "onion"
signal picked_up(name: String)

func _on_body_entered(body: Node):
	if body.name == "Player":
		picked_up.emit(ingredient_name)
		queue_free()
