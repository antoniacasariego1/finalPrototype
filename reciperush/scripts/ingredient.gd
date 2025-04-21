extends Area2D

@export var ingredient_name: String = "onion"
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

func _on_body_entered(body: Node):
	if body.name == "chef":
		picked_up.emit(ingredient_name)
		queue_free()
