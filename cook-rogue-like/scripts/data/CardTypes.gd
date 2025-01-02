class_name CardTypes

enum CardType {EQUIPMENT, INGREDIENT, DEVICE, RECIPE}
enum Action {CUT, SQUEEZE, MIX, COOK, SELL, STORE}
enum SubType {VEG, SAUCE, MEAT, NONE}
enum Location {
    IN_SHOP,
    IN_HAND,
    IN_DECK,
    ON_FIELD
}

static var CARD_SIZE = Vector2(35, 49)
static var CARD_SCALE = 8