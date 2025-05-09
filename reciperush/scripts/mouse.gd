extends CharacterBody2D

@export var speed := 70
var target: Node = null

func _ready():
	input_pickable = true
	add_to_group("mice")
	target = get_closest_ingredient()
	$CollisionShape2D.disabled = false
	collision_mask = 0

func _physics_process(delta):
	if target and is_instance_valid(target):
		velocity = (target.global_position - global_position).normalized() * speed
		move_and_slide()
	else:
		target = get_closest_ingredient()

func get_closest_ingredient():
	var closest = null
	var min_dist = INF
	for ing in get_tree().get_nodes_in_group("ingredients"):
		if not is_instance_valid(ing): continue
		var dist = global_position.distance_to(ing.global_position)
		if dist < min_dist:
			min_dist = dist
			closest = ing
	return closest

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		queue_free()

func _on_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("ingredients"):
		print("Rat stole an ingredient! Restarting level.")
		get_tree().reload_current_scene()
