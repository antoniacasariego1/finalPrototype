extends Node2D

var recipe_active = false
var ingredients_needed: Array[String] = []
var ingredients_collected: Array[String] = []

func _ready():
	# Hide inventory at first
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	$UI/InventoryPanel.visible = false

	# Connect all ingredients in the group
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

# --- Updates the UI based on what the player has collected
func update_inventory():
	var steak_icon = $UI/InventoryPanel/HBoxContainer/SteakIcon
	var onion_icon = $UI/InventoryPanel/HBoxContainer/OnionIcon
	var pepper_icon = $UI/InventoryPanel/HBoxContainer/PepperIcon

	if steak_icon: steak_icon.visible = "steak" in ingredients_collected
	if onion_icon: onion_icon.visible = "onion" in ingredients_collected
	if pepper_icon: pepper_icon.visible = "pepper" in ingredients_collected


# --- Check if player got all ingredients
func check_completion():
	if ingredients_collected.size() == ingredients_needed.size():
		print("All ingredients collected! Moving to Level 3...")
		await get_tree().create_timer(0.5).timeout  # short delay for sound
		get_tree().change_scene_to_file("res://scenes/level_three.tscn")





func _on_recipe_picked_up() -> void:
	$RecipePickUp.play()
	if $KitchenDoor:                       # safety check
		$KitchenDoor.queue_free()          # unlock passage
	$DoorOpenSound.play()
	print("Recipe picked up!")
	recipe_active = true
	ingredients_needed = ["steak", "onion", "pepper"]
	$UI/InventoryPanel.visible = true
	$UI/RecipeTrack.visible = true
	update_inventory()
