class_name Hand extends Resource

var hand: Dictionary = {}
var MAX_HAND_SIZE: int = 5

func add_to_hand(card: Card):
    hand[card.id] = card

    if hand.size() > MAX_HAND_SIZE:
        return play_random_card()

    return null

func remove_from_hand(card_id: String):
    hand.erase(card_id)

func select_card(card_id: String) -> Card:
    return hand[card_id]

func play_card(card_id: String) -> Card:
    var card = hand.get(card_id)
    hand.erase(card_id)
    return card

func play_random_card() -> Card:
    return play_card(hand.keys().pick_random())

func get_hand() -> Array:
    return hand.values()

func size() -> int:
    return hand.size()