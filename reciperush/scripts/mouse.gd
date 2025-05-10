extends CharacterBody2D

@export var speed := 80
var target: Node = null
var stolen_ingredient_name: String = ""

func _ready():
	input_pickable = true
	$CollisionShape2D.disabled = false
	collision_mask = 0
	target = get_closest_ingredient()

func _physics_process(delta):
	if target and is_instance_valid(target):
		var dir = (target.global_position - global_position).normalized()
		velocity = dir * speed
		move_and_slide()
	else:
		target = get_closest_ingredient()

func get_closest_ingredient():
	var closest = null
	var min_dist = INF
	for ing in get_tree().get_nodes_in_group("ingredients"):
		if is_instance_valid(ing):
			var dist = global_position.distance_to(ing.global_position)
			if dist < min_dist:
				min_dist = dist
				closest = ing
	return closest

func _on_body_entered(body: Node):
	if body.is_in_group("ingredients") and stolen_ingredient_name == "":
		if body.has_variable("ingredient_name"):
			stolen_ingredient_name = body.ingredient_name
			print("Rat stole:", stolen_ingredient_name)
			body.queue_free()
			target = get_closest_ingredient()
		else:
			print("Ingredient doesn't have 'ingredient_name'")

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if stolen_ingredient_name != "":
			print("Rat clicked! Returning:", stolen_ingredient_name)
			get_tree().call_group("level", "return_stolen_ingredient", stolen_ingredient_name)
		else:
			print("Rat clicked! No ingredient to return.")
		queue_free()

func _on_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("ingredients"):
		print("Rat stole an ingredient! Restarting level.")
		get_tree().reload_current_scene()
