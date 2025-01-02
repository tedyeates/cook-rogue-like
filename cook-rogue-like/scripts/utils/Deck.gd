class_name Deck extends Resource

var deck: Array[Card]

func _init():
    deck = []

func add_to_deck(card: Card):
    deck.append(card)

func add_to_deck_bottom(card: Card):
    deck.push_front(card)

func draw_from_deck(card_number: int) -> Array[Card]:
    var drawn_cards = []
    for i in range(card_number):
        var card = deck.pop_back()
        drawn_cards.append(card)
        
    return drawn_cards

func draw() -> Card:
    return deck.pop_back()

func search(attribute: String, value: String) -> Card:
    for i in range(deck.size() - 1):
        if deck[i].get(attribute) == value:
            return deck.pop_at(i)

    return null

func search_many(attribute: String, value: String, number_cards: int = -1) -> Array[Card]:
    var cards = []
    for i in range(deck.size() - 1):
        if number_cards > -1 and cards.size() >= number_cards:
            break

        if deck[i].get(attribute) == value:
            cards.append(deck.pop_at(i))
            
    return cards

func shuffle():
    deck.shuffle()

func reset_deck():
    deck.clear()

func get_cards() -> Array[Card]:
    return deck

func get_card_at(index: int) -> Card:
    return deck[index]

func size():
    return deck.size()
