class_name CardGUI extends Node2D

@export var label: String
@export var description: String
@export var cost: int
@export var image: Texture2D
@export var background: Texture2D

@onready var cost_label: Label = $CostDisplay/CostLabel
@onready var description_label: Label = $DescriptionDisplay/DescriptionLabel
@onready var name_label: Label = $NameDisplay/NameLabel
@onready var image_display: Sprite2D = $ImageDisplay/ImageSprite
@onready var background_display: Sprite2D = $BackgroundSprite

@onready var front_components = [$DescriptionDisplay, $NameDisplay, background_display, $ImageDisplay]

var type: CardTypes.CardType
var action: CardTypes.Action
var face_up: bool
var location: CardTypes.Location

# Instantiate
func set_values(
	_label: String, _description: String, _cost: int, _location: CardTypes.Location, 
	_face_up: bool, _image: Texture2D, _background: Texture2D
):
	image = _image
	background = _background
	label = _label
	description = _description
	cost = _cost

	location = _location
	face_up = _face_up


func _get_image_folder_path(_type: CardTypes.CardType) -> String:
	return {
		CardTypes.CardType.EQUIPMENT: "equipment",
		CardTypes.CardType.INGREDIENT: "ingredients",
		CardTypes.CardType.DEVICE: "devices",
		CardTypes.CardType.RECIPE: "recipes"
	}[_type]

func _get_image(_type: CardTypes.CardType, _name: String) -> Texture2D:
	var folder = _get_image_folder_path(_type)
	return load("res://assets/%s/%s.png" % [folder, _name])

func _get_backgeround_file_name(_type: CardTypes.CardType, _sub_type: CardTypes.SubType) -> String:
	if _sub_type != null and _sub_type != CardTypes.SubType.NONE:
		return {
			CardTypes.SubType.MEAT: "meatcard",
			CardTypes.SubType.VEG: "vegcard",
			CardTypes.SubType.SAUCE: "saucecard"
		}[_sub_type]
	
	return {
		CardTypes.CardType.EQUIPMENT: "equipmentcard",
		CardTypes.CardType.DEVICE: "devicecard",
		CardTypes.CardType.RECIPE: "recipecard"
	}[_type]

func _get_background(_type: CardTypes.CardType, _sub_type=null) -> Texture2D:
	var file_name = _get_backgeround_file_name(_type, _sub_type)
	return load("res://assets/cardbase/%s.png" % [file_name])


func set_values_from_card(card: Card, _location: CardTypes.Location, _face_up: bool = false):
	set_values(
		card.label, 
		card.description, 
		card.cost, 
		_location, 
		_face_up, 
		_get_image(card.type, card.name), 
		_get_background(card.type, card.sub_type)
	)

func create_instance(
	card: Card, 
	parent: Node2D, 
	_location: CardTypes.Location, 
	translation_vector: Vector2 = Vector2.ZERO,
	_face_up: bool = false
):
	self.set_values_from_card(card, _location, _face_up)
	parent.add_child(self)

	self.position += translation_vector

# Flip Card
func hide_cost():
	$CostDisplay.visible = false

func show_cost():
	if location == CardTypes.Location.IN_SHOP:
		$CostDisplay.visible = true


func show_back():
	for component in front_components:
		component.visible = false

	$BackgroundSprite.visible = false
	$CardBackSprite.visible = true
	hide_cost()
	face_up = false

func show_front():
	for component in front_components:
		component.visible = true

	$BackgroundSprite.visible = true
	$CardBackSprite.visible = false
	show_cost()
	face_up = true


func show_card(_show_front:bool = true):
	if _show_front:
		show_front()
	else:
		show_back()


func display_values():
	image_display.texture = image
	background_display.texture = background
	name_label.text = label
	description_label.text = description
	cost_label.text = str(cost)
	show_card(face_up)   


# Main
func _test_card_display():
	var card_database = CardDatabase.new()
	var card_data = card_database.get_card("tomato")
	var _id = card_database.generate_id()
	set_values_from_card(
		Card.new_card(_id, card_data, card_database),
		CardTypes.Location.IN_SHOP, 
		false
	)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# _test_card_display()
	display_values()

	# $CardClickArea.connect("input_event", card_activated)
	var card_click_area = $CardClickArea
	card_click_area.connect("mouse_entered", bob_up)
	card_click_area.connect("mouse_exited", bob_down)

	print("ready")


# Signal overrides
func bob_up():
	if location == CardTypes.Location.IN_HAND:
		self.position.y -= 5

func bob_down():
	if location == CardTypes.Location.IN_HAND:
		self.position.y += 5

func card_activated(_viewport, event, _shapeindex):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			show_card(!face_up)
