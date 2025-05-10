extends Node2D

var recipe_active = false
var ingredients_needed: Array[String] = []
var ingredients_collected: Array[String] = []
var all_ingredients_collected = false

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	$UI/InventoryPanel.visible = false

	for ingredient in get_tree().get_nodes_in_group("ingredients"):
		ingredient.picked_up.connect(_on_ingredient_picked)

func _on_ingredient_picked(name: String):
	if not recipe_active:
		return

	if name in ingredients_needed and name not in ingredients_collected:
		ingredients_collected.append(name)
		update_inventory()
		check_completion()
		
	if ingredients_collected.size() >= 1:
		spawn_rat_near_player()
		spawn_rat_near_player()

func update_inventory():
	var potato_icon = $UI/InventoryPanel/HBoxContainer/PotatoIcon
	var cheese_icon = $UI/InventoryPanel/HBoxContainer/CheeseIcon
	var pumpkin_icon = $UI/InventoryPanel/HBoxContainer/PumpkinIcon
	var tomato_soup_icon = $UI/InventoryPanel/HBoxContainer/TomatoSoupIcon

	if potato_icon: potato_icon.visible = "potato" in ingredients_collected
	if cheese_icon: cheese_icon.visible = "cheese" in ingredients_collected
	if pumpkin_icon: pumpkin_icon.visible = "pumpkin" in ingredients_collected
	if tomato_soup_icon: tomato_soup_icon.visible = "tomato_soup" in ingredients_collected


func check_completion():
	if ingredients_collected.size() == ingredients_needed.size():
		print("All ingredients collected! Go to the stove.")
		all_ingredients_collected = true
		if $Stove:
			$Stove.set_interactable(true)

func on_cooking_finished():
	print("Cooking complete! Moving to Win Screen...")
	get_tree().change_scene_to_file("res://scenes/win.tscn")



func _on_recipe_recipe_recipe_picked_up() -> void:
	$RecipePickUp.play()
	if $KitchenDoor:
		$KitchenDoor.queue_free()
	$DoorOpenSound.play()
	print("Recipe picked up!")
	recipe_active = true
	ingredients_needed = ["potato", "cheese", "pumpkin", "tomato_soup"]
	$UI/InventoryPanel.visible = true
	$UI/RecipeTrack.visible = true
	update_inventory()

func spawn_rat_near_player():
	var rat_scene = preload("res://scenes/mouse.tscn")  # adjust path if needed
	var rat = rat_scene.instantiate()
	var offset = Vector2(randf_range(-8, 8), randf_range(-8, 8))
	rat.global_position = $Player.global_position 
	add_child(rat)
