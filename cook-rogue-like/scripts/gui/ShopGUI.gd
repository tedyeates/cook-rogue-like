extends GridContainer

@onready var card = preload("res://scenes/card.tscn")


var shop: Shop

func add_item_to_shop(type: CardTypes.CardType, data: Dictionary) -> void:
	match type:
		CardTypes.CardType.INGREDIENT:
			shop.add_ingredient(data["label"], data["name"], data["cost"])
		CardTypes.CardType.DEVICE:
			shop.add_device(data["label"], data["name"], data["cost"], data["action"])
		CardTypes.CardType.EQUIPMENT:
			shop.add_equipment(data["label"], data["name"], data["cost"], data["action"])

func add_recipe_to_shop(data: Dictionary) -> void:
	shop.add_recipe(data["label"], data["name"], data["item_required"], data["steps"], data["money"])

func populate_shop():
	var tomato = shop.available_ingredients["tomato"]
	var lettuce = shop.available_ingredients["lettuce"]

	add_item_to_shop(CardTypes.CardType.INGREDIENT, tomato)
	add_item_to_shop(CardTypes.CardType.INGREDIENT, lettuce)

	var knife = shop.available_equipment["knife"]
	add_item_to_shop(CardTypes.CardType.EQUIPMENT, knife)

	var salad = shop.available_recipes["salad"]
	add_recipe_to_shop(salad)

func display_shop():
	var shop_areas = [
		{"location": $Ingredients, "card_storage": shop.ingredients}, 
		{"location": $Equipment, "card_storage": shop.equipment}, 
		{"location": $Devices, "card_storage": shop.devices}
	]

	for area in shop_areas:
		var index = 0
		for item in area["card_storage"].values():
			var instance = card.instantiate().with_data(
				item.label, 
				item.type, 
				item.action, 
				item.cost, 
				true, 
				true
			)

			area["location"].add_child(instance)

			index += 1
	
	print(shop.ingredients)
	print(shop.equipment)
	print(shop.devices)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shop = Shop.new()
	populate_shop()
	display_shop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
