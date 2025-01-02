class_name Device extends Card

var card_database: CardDatabase

var cards: Array[Card]
var cards_process_max: int

var actions = {
    CardTypes.Action.CUT: {
        "lemon": [["lemon_slice", 4]],
        "tomato": [["tomato_slice", 4]],
        "lettuce": [["lettuce_slice", 4]]
    },
    CardTypes.Action.SQUEEZE: {
        "lemon_slice": [["lemon_juice", 1]]
    },
    CardTypes.Action.COOK: {
        "fish_skewer_honey_lemon": [["cooked_fish_skewer_honey_lemon", 1]]
    },
    CardTypes.Action.MIX: {
        "tomato_slice": [["salad", 1]],
        "lettuce_slice": [["salad", 1]],
        "shit": [["shit", 1]]
    }
}

func _init(
    _id: int, _label: String, _name: String, _description: String,
    _action: CardTypes.Action,  
    _cost: int, _uses: int, _unbreakable: bool,
    _card_database: CardDatabase,
    _cards_process_max: int = 2,
):
    cards_process_max = _cards_process_max
    card_database = _card_database
    super(
        _id, _label, _name, _description,
        CardTypes.CardType.DEVICE, CardTypes.SubType.NONE, _action,
        _cost, _uses, _unbreakable
    )


func take_card():
    return cards.pop_back()

func add_card(card: Card):
    if card.type != CardTypes.CardType.INGREDIENT: return false

    cards.append(card)
    return true

func process_cards(equipment: Card) -> Array[Card]:
    var output_cards: Array[Card] = []
    var recipes = []
    var status = true
    while cards.size() > 0:
        var ingredient = take_card()

        if not status: continue

        if ingredient.name not in actions[equipment.action]:
            return output_cards

        status = _action_cards(output_cards, equipment, ingredient, recipes)

        _use_device(equipment)
    
    return output_cards
    

func _use_device(equipment: Card):
    if not unbreakable:
        uses -= 1

    if not equipment.unbreakable:
        equipment.uses -= 1

func _create_card(card: Dictionary):
    var _id = card_database.generate_id()
    return Card.new_card(_id, card, card_database)

func _create_crafted_cards(output_cards: Array[Card], crafted_cards: Array):
    for crafted_card in crafted_cards:
        var card = card_database.get_card(crafted_card[0])

        for i in range(crafted_card[1]):
            output_cards.append(_create_card(card))

func _fulfill_recipe(recipe: Dictionary, output_cards: Array[Card], card: Card):
    recipe["requirements"][card.name] -= 1
    # Completed requirement for recipe
    if recipe["requirements"][card.name] <= 0:
        recipe["requirements"].erase(card.name)

    # Completed recipe
    if recipe["requirements"].empty():
        output_cards.append(_create_card(recipe))
        return true

    return false


func _cut_cards(output_cards: Array[Card], card: Card):
    var crafted_cards = actions[CardTypes.Action.CUT][card.name]
    _create_crafted_cards(output_cards, crafted_cards)
    return true


func _mix_cards(output_cards: Array[Card], recipes: Array, card: Card):
    if recipes.size() == 0:
        var recipe_names = actions[CardTypes.Action.MIX][card.name]

        for recipe_name in recipe_names:
            recipes.append(card_database.get_card(recipe_name))

    var useable_card = false
    var used_recipes = []
    while recipes.size() > 0:
        var recipe = recipes.pop_back()

        if "requirements" not in recipes: continue
        if card.name not in recipe["requirements"]: continue

        used_recipes.append(recipe)
        useable_card = true

        var fufilled = _fulfill_recipe(recipe, output_cards, card)
        if fufilled: return true

    if not useable_card: 
        output_cards.append(_create_card(card_database.get_card("shit")))
        return false

    # Limit recipes based on what ingredient fullfills
    recipes.append_array(used_recipes)
    return true
    

func _action_cards(
    output_cards: Array[Card], equipment: Card, ingredient: Card,
    recipes: Array
) -> bool:
    match equipment.action:
        CardTypes.Action.CUT:
            return _cut_cards(output_cards, ingredient)
        CardTypes.Action.MIX:
            return _mix_cards(output_cards, recipes, ingredient)
        _:
            return false

    

# TODO: IMPLEMENT
func _cook_ingredients(equipment: Card) -> Array[Card]:
    return []
