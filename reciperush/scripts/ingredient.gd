extends Area2D

@export var ingredient_name: String = "onion"
@export var can_be_stolen: bool = true
signal picked_up(name: String)

var ingredient_textures := {
	"onion": preload("res://assets/Food Icons/Separated Icons/onion.png"),
	"steak": preload("res://assets/Food Icons/Separated Icons/steak.png"),
	"pepper": preload("res://assets/Food Icons/Separated Icons/pepper.png"), 
	"corn": preload("res://assets/Food Icons/Separated Icons/corn.png"),
	"avocado": preload("res://assets/Food Icons/Separated Icons/avocado.png"),
	"egg": preload("res://assets/Food Icons/Separated Icons/egg.png"),
	"chicken": preload("res://assets/Food Icons/Separated Icons/chicken.png"), 
	"potato": preload("res://assets/Food Icons/Separated Icons/potato.png"),
	"cheese": preload("res://assets/Food Icons/Separated Icons/cheese.png"),
	"pumpkin": preload("res://assets/Food Icons/Separated Icons/pumpkin.png"),
	"tomato_soup": preload("res://assets/Food Icons/Separated Icons/tomatosoup.png")
}

func _ready() -> void:
	if ingredient_textures.has(ingredient_name):
		$Sprite2D.texture = ingredient_textures[ingredient_name]
	else:
		print("Missing texture for:", ingredient_name)

	add_to_group("ingredients")

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		if $PickupSound:
			$PickupSound.play()
		picked_up.emit(ingredient_name)
		await get_tree().create_timer(0.2).timeout
		queue_free()
	elif body.name == "mouse" and can_be_stolen:
		print(ingredient_name, "was stolen by a mouse!")
		queue_free()
		var scene_path = get_tree().current_scene.scene_file_path
		if scene_path.find("level_three") != -1:
			get_tree().change_scene_to_file("res://scenes/lost.tscn")
		else: 
			get_tree().reload_current_scene()
