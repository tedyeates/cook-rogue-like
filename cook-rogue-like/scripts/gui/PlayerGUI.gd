extends Node

var hand: Hand
var card_database: CardDatabase

var card_gui: PackedScene = preload("res://scenes/card.tscn")

var starting_cards = [
    {"name": "lettuce", "count": 3},
    {"name": "tomato", "count": 2},
]

func _display_hand(hand_node: Node2D, _hand: Hand):
    var index = 0
    for card in _hand.get_hand():
        var translation_vector = Vector2(
            index * (CardTypes.CARD_SIZE.x + 2), 0
        )

        var card_gui_instance = card_gui.instantiate()
        card_gui_instance.create_instance(
            card, hand_node, CardTypes.Location.IN_HAND, 
            translation_vector, true
        )

        index += 1

func _fill_hand(_hand: Hand, card_name_list: Array):
    """Add default cards to data deck"""
    for card_identifier in card_name_list:
        for i in range(card_identifier["count"]):
            var card_data = card_database.get_card(card_identifier["name"])
            var _id = card_database.generate_id()
            _hand.add_to_hand(Card.new_card(_id, card_data, card_database))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    hand = Hand.new()
    card_database = CardDatabase.new()

    _fill_hand(hand, starting_cards)
    _display_hand($CanvasLayer/Hand, hand)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
