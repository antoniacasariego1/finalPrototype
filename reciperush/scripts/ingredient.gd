extends Area2D

@export var ingredient_name: String = "onion"
@export var can_be_stolen: bool = true
signal picked_up(name: String)

var ingredient_textures = {
	"onion": preload("res://assets/Food Icons/Separated Icons/onion.png"),
	"steak": preload("res://assets/Food Icons/Separated Icons/steak.png"),
	"pepper": preload("res://assets/Food Icons/Separated Icons/pepper.png")
}

func _ready():
	if ingredient_textures.has(ingredient_name):
		$Sprite2D.texture = ingredient_textures[ingredient_name]
	else:
		print("Missing texture for:", ingredient_name)

	# Optional: add this node to "ingredients" group for AI targeting
	add_to_group("ingredients")

func _on_body_entered(body: Node):
	if body.name == "Player":
		picked_up.emit(ingredient_name)
		queue_free()

	elif body.name == "mouse" and can_be_stolen:
		print(ingredient_name, "was stolen by a mouse!")
		queue_free()
