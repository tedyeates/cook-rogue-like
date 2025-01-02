class_name Shop extends RefCounted

@export var card_database: CardDatabase

var ingredients: Dictionary
var equipment: Dictionary
var devices: Dictionary
var recipes: Dictionary

func add_ingredient(label: String, name: String, cost: int):
    var card_id = card_database.generate_id()
    ingredients[card_id] = Card.new_ingredient(card_id, label, name, cost)

func add_device(label: String, name: String, cost: int, action: CardTypes.Action):
    var card_id = card_database.generate_id()
    devices[card_id] = Card.new_device(card_id, label, name, cost, action)

func add_equipment(label: String, name: String, cost: int, action: CardTypes.Action):
    var card_id = card_database.generate_id()
    equipment[card_id] = Card.new_equipment(card_id, label, name, cost, action)

func add_recipe(label: String, name: String, item_required: String, steps: Array, money: int):
    var card_id = card_database.generate_id()
    recipes[card_id] = Recipe.new(card_id, label, name, item_required, steps, money)

func buy_card(card: Card, player: Player):
    if player.money < card.cost:
        return false

    player.money -= card.cost
    match card.type:
        CardTypes.CardType.INGREDIENT:
            player.add_card(card)
            ingredients.erase(card.id)
        CardTypes.CardType.DEVICE:
            player.add_device(card)
            devices.erase(card.id)
        CardTypes.CardType.EQUIPMENT:
            player.add_card(card)
            equipment.erase(card.id)

    return true
