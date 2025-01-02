class_name Team extends Resource

var card_collection: Dictionary = {}
var devices: Dictionary = {}

func _init(_money: int):
	money = _money
	
func add_card(card: Card):
	card_collection[card.id] = card

# TODO: move to team
func add_device(card: Card):
	devices[card.id] = card
	
func update_card(card_id: String, card: Card):
	card_collection[card_id] = card
	
func remove_card(card_id: String):
	card_collection.erase(card_id)

func remove_device(card_id: String):
	devices.erase(card_id)
	
func get_cards() -> Array[Card]:
	return card_collection.values()

func get_devices() -> Array[Card]:
	return devices.values()
	
