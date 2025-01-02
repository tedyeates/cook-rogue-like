class_name Card extends RefCounted

var id: int
var label: String
var name: String
var description: String
var type: CardTypes.CardType
var sub_type: CardTypes.SubType
var action: CardTypes.Action
var cost: int
var uses: int
var unbreakable: bool

func _init(
	_id: int, _label: String, _name: String, _description: String,
	_type: CardTypes.CardType, _sub_type: CardTypes.SubType, _action: CardTypes.Action,
	_cost: int, _uses: int, _unbreakable: bool,
):
	id = _id
	label = _label
	type = _type
	sub_type = _sub_type
	name = _name
	description = _description
	action = _action
	cost = _cost
	uses = _uses
	unbreakable = _unbreakable


static func _new_card(
	_id: int, _label: String, _name: String, _description: String,
	_type: CardTypes.CardType, _sub_type: CardTypes.SubType, _action: CardTypes.Action,
	_cost: int, _uses: int, _unbreakable: bool,
	_card_database: CardDatabase = null,
	_cards_process_max: int = 0
) -> Card:
	if _type == CardTypes.CardType.DEVICE:
		return Device.new(
			_id, _label, _name, _description,
			_action,
			_cost, _uses, _unbreakable,
			_card_database,
			_cards_process_max
		)

	return Card.new(
		_id, _label, _name, _description,
		_type, _sub_type,_action, 
		_cost, _uses, _unbreakable
	)


static func new_card(_id: int, _data: Dictionary, _card_database: CardDatabase = null) -> Card:
	return _new_card(
		_id, _data.get("label"), _data.get("name"), _data.get("description"),
		_data.get("type"), _data.get("sub_type"), _data.get("action"),
		_data.get("cost"), _data.get("uses"), _data.get("unbreakable"),
		_card_database, _data.get("cards_process_max", 0)
	)


func _to_string():
	return label


# Ingredients have freshness timer before rotting
# Ingredients have cooking time and time before burnt
# Food poisoning chance? Hand wash sink?
