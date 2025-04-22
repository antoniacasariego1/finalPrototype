extends Node2D

var ingredients_needed = []
var ingredients_collected: Array[String] = []
var recipe_active = false

func _ready():
	$UI/InventoryPanel.visible = false

	# Connect signals for all ingredient nodes in the scene
	for ingredient in get_tree().get_nodes_in_group("ingredients"):
		ingredient.picked_up.connect(_on_ingredient_picked)

func _on_recipe_picked_up():
	print("Recipe picked up!")
	recipe_active = true

	ingredients_needed = ["steak", "onion", "pepper"]

	$UI/InventoryPanel.visible = true

func _on_ingredient_picked(name: String):
	if not recipe_active:
		return

	if name in ingredients_needed and name not in ingredients_collected:
		ingredients_collected.append(name)
		update_inventory()
		check_completion()

func update_inventory():
	if "steak" in ingredients_collected:
		$UI/InventoryPanel/SteakIcon.visible = true
	if "onion" in ingredients_collected:
		$UI/InventoryPanel/OnionIcon.visible = true
	if "pepper" in ingredients_collected:
		$UI/InventoryPanel/PepperIcon.visible = true

func check_completion():
	if ingredients_collected.size() == ingredients_needed.size():
		$ExitZone.visible = true
