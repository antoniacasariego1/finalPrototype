extends CharacterBody2D

@export var speed := 60
var target_ingredient: Node = null

func _ready():
	find_new_target()

func _physics_process(delta):
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

# 👇 Add this function to support clicking on rats to kill them
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		queue_free()
