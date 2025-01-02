extends Node

var card_gui: PackedScene = preload("res://scenes/card.tscn")
@export var card_database: CardDatabase

var devices: Deck

func _display_deck(deck_node: Node2D, deck: Deck, deck_area: Area2D):
    """Renderd card from deck onto a deck node"""
    var translation_vector: Vector2 = Vector2.ZERO
    for i in range(deck.size()):
        # Instantiate cards in deck
        var card = deck.get_card_at(i)

        translation_vector = Vector2(i * .1, i * -.1)
        var card_gui_instance = card_gui.instantiate()
        card_gui_instance.create_instance(
            card, deck_node, CardTypes.Location.IN_DECK,
            translation_vector, true
        )

    # Click area for deck
    deck_area.position += translation_vector


func _display_devices(device_node: Node2D, _devices: Deck):
    for i in range(_devices.size()):
        var translation_vector = Vector2(
            i * (CardTypes.CARD_SIZE.x + 2), 0
        )

        var card_gui_instance = card_gui.instantiate()
        card_gui_instance.create_instance(
            _devices.get_card_at(i), device_node, CardTypes.Location.ON_FIELD, 
            translation_vector, true
        )

func _fill_devices(_devices: Deck, card_name_list: Array[Dictionary]):
    """Add default cards to data deck"""
    for card_identifier in card_name_list:
        for i in range(card_identifier["count"]):
            var card_data = card_database.get_card(card_identifier["name"])
            var _id = card_database.generate_id()
            _devices.add_to_deck(Card.new_card(_id, card_data, card_database))

    _devices.shuffle()


# func _fill_deck(deck: Deck, card_name_list: Array[Dictionary]):
#     """Add default cards to data deck"""
#     for card_identifier in card_name_list:
#         for i in range(card_identifier["count"]):
#             var card_data = card_database.get_card(card_identifier["name"])
#             var _id = card_database.generate_id()
#             deck.add_to_deck(Card.new_card(_id, card_data, card_database))

#     deck.shuffle()

func _ready() -> void:
    devices = Deck.new()
    _fill_devices(devices, [
        {"name": "counter_top", "count": 1},
        {"name": "chopping_board", "count": 1},
    ])
    _display_devices($Devices, devices)


func _process(delta: float) -> void:
    pass


# Team has money
# Team has devices
# Team has cards
# Counter tops contain decks can choose where to buy cards into
