extends CharacterBody2D

@export var speed := 30
var target_ingredient: Node = null
var stolen_ingredient_name: String = ""

func _ready():
	find_new_target()

func _process(delta):
	if target_ingredient and is_instance_valid(target_ingredient):
		var direction = (target_ingredient.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
	else:
		find_new_target()

func find_new_target():
	var ingredients = get_tree().get_nodes_in_group("ingredients")
	if ingredients.size() > 0:
		target_ingredient = ingredients[randi() % ingredients.size()]

func _on_body_entered(body: Node):
	if body.is_in_group("ingredients") and stolen_ingredient_name == "":
		if body.has_variable("ingredient_name"):
			stolen_ingredient_name = body.ingredient_name
			print("🧀 Rat stole:", stolen_ingredient_name)
			body.queue_free()
		else:
			print("⚠️ Ingredient doesn't have 'ingredient_name'")

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if stolen_ingredient_name != "":
			print("🐀 Rat clicked! Returning:", stolen_ingredient_name)
			get_tree().call_group("level", "return_stolen_ingredient", stolen_ingredient_name)
		else:
			print("🐀 Rat clicked! No ingredient to return.")
		queue_free()
