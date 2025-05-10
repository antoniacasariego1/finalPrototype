extends CharacterBody2D

@export var speed := 90
var target_ingredient: Node = null

func _ready():
	add_to_group("rival")
	target_ingredient = get_next_ingredient()

func _physics_process(delta):
	if target_ingredient and is_instance_valid(target_ingredient):
		var distance = global_position.distance_to(target_ingredient.global_position)
		if distance < 5:  # Adjust this threshold as needed
			velocity = Vector2.ZERO
			return
		var dir = (target_ingredient.global_position - global_position).normalized()
		velocity = dir * speed
		move_and_slide()
	else:
		target_ingredient = get_next_ingredient()


func get_next_ingredient():
	var ings = get_tree().get_nodes_in_group("ingredients")
	var closest = null
	var min_dist = INF
	for ing in ings:
		if is_instance_valid(ing):
			var dist = global_position.distance_to(ing.global_position)
			if dist < min_dist:
				min_dist = dist
				closest = ing
	return closest

func _on_body_entered(body: Node2D):
	if body.is_in_group("ingredients"):
		print("Rival Chef took:", body.name)
		body.queue_free()
		target_ingredient = get_next_ingredient()
