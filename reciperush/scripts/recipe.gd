extends Area2D
signal recipe_picked_up


func _ready():
	var scene_path = get_tree().current_scene.scene_file_path
	if scene_path.find("level_one") != -1:
		$Sprite2D.texture = preload("res://assets/recipe.png")
	elif scene_path.find("level_two") != -1:
		$Sprite2D.texture = preload("res://assets/level2_recipe.png")
		
func _on_body_entered(body: Node):
	print("something touched me:", body.name)
	if body.name == "Player":
		print("Player touched recipe!")
		recipe_picked_up.emit()
		queue_free()
