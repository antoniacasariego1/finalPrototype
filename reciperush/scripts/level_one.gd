extends Node2D

var recipe_active = false
var ingredients_needed: Array[String] = []
var ingredients_collected: Array[String] = []

func _ready():
	# Hide inventory at first
	$UI/InventoryPanel.visible = false

	# Connect all ingredients in the group
	for ingredient in get_tree().get_nodes_in_group("ingredients"):
		ingredient.picked_up.connect(_on_ingredient_picked)

# --- When the player picks up the recipe
func _on_recipe_picked_up():
	print("📜 Recipe picked up!")
	recipe_active = true
	ingredients_needed = ["steak", "onion", "pepper"]
	$UI/InventoryPanel.visible = true
	update_inventory()

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
	$UI/InventoryPanel/SteakIcon.visible = "steak" in ingredients_collected
	$UI/InventoryPanel/OnionIcon.visible = "onion" in ingredients_collected
	$UI/InventoryPanel/PepperIcon.visible = "pepper" in ingredients_collected

# --- Check if player got all ingredients
func check_completion():
	if ingredients_collected.size() == ingredients_needed.size():
		print("✅ All ingredients collected!")
		# Show exit / trigger next level here
		if $ExitZone:
			$ExitZone.visible = true
