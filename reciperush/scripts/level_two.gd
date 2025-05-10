extends Node2D

var recipe_active = false
var ingredients_needed: Array[String] = []
var ingredients_collected: Array[String] = []

var all_ingredients_collected = false

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	$UI/InventoryPanel.visible = false

	# Show rat instructions temporarily
	if $RatInstructions:
		$RatInstructions.visible = true
		await get_tree().create_timer(5.0).timeout
		$RatInstructions.visible = false

	for ingredient in get_tree().get_nodes_in_group("ingredients"):
		ingredient.picked_up.connect(_on_ingredient_picked)


# --- When an ingredient is picked up
func _on_ingredient_picked(name: String):
	if not recipe_active:
		return

	if name in ingredients_needed and name not in ingredients_collected:
		ingredients_collected.append(name)
		update_inventory()
		check_completion()
	
	if ingredients_collected.size() >= 1:
		spawn_rat_near_player()
		

# --- Updates the UI based on what the player has collected
func update_inventory():
	var corn_icon = $UI/InventoryPanel/HBoxContainer/CornIcon
	var avocado_icon = $UI/InventoryPanel/HBoxContainer/AvocadoIcon
	var egg_icon = $UI/InventoryPanel/HBoxContainer/EggIcon
	var chicken_icon = $UI/InventoryPanel/HBoxContainer/ChickenIcon

	if corn_icon: corn_icon.visible = "corn" in ingredients_collected
	if avocado_icon: avocado_icon.visible = "avocado" in ingredients_collected
	if egg_icon: egg_icon.visible = "egg" in ingredients_collected
	if chicken_icon: chicken_icon.visible = "chicken" in ingredients_collected


# --- Check if player got all ingredients
func check_completion():
	if ingredients_collected.size() == ingredients_needed.size():
		print("All ingredients collected! Go to the stove.")
		all_ingredients_collected = true
		if $Stove:
			$Stove.set_interactable(true)

# --- Called by stove.gd after cooking finishes
func on_cooking_finished():
	print("Cooking complete! Moving to Level 2...")
	get_tree().change_scene_to_file("res://scenes/level_two.tscn")

func _on_recipe_picked_up() -> void:
	$RecipePickUp.play()
	if $KitchenDoor:
		$KitchenDoor.queue_free()
	$DoorOpenSound.play()
	print("Recipe picked up!")
	recipe_active = true
	ingredients_needed = ["corn", "avocado", "egg", "chicken"]
	$UI/InventoryPanel.visible = true
	$UI/RecipeTrack.visible = true
	update_inventory()

func spawn_rat_near_player():
	var rat_scene = preload("res://scenes/mouse.tscn")  # adjust path if needed
	var rat = rat_scene.instantiate()
	var offset = Vector2(randf_range(-8, 8), randf_range(-8, 8))
	rat.global_position = $Player.global_position 
	add_child(rat)
