class_name CardDatabase extends Resource

var card_id: int = 0

var available_cards = {
	"lemon": {
		"label": "Lemon",
		"name": "lemon",
		"description": "Ingredient",
        "type": CardTypes.CardType.INGREDIENT,
        "sub_type": CardTypes.SubType.VEG,
        "action": CardTypes.Action.MIX,
        "cost": 1,
        "uses": 1,
        "unbreakable": false,
	},
	"tomato": {
		"label": "Tomato",
		"name": "tomato",
		"description": "Ingredient",
        "type": CardTypes.CardType.INGREDIENT,
        "sub_type": CardTypes.SubType.VEG,
        "action": CardTypes.Action.MIX,
        "cost": 2,
        "uses": 1,
        "unbreakable": false
	},
	"lettuce": {
		"label": "Lettuce",
		"name": "lettuce",
		"description": "Ingredient",
        "type": CardTypes.CardType.INGREDIENT,
        "sub_type": CardTypes.SubType.VEG,
        "action": CardTypes.Action.MIX,
        "cost": 1,
        "uses": 1,
        "unbreakable": false
	},
	"honey": {
		"label": "Honey",
		"name": "honey",
		"description": "Ingredient",
        "type": CardTypes.CardType.INGREDIENT,
        "sub_type": CardTypes.SubType.VEG,
        "action": CardTypes.Action.MIX,
        "cost": 2,
        "uses": 4,
        "unbreakable": false
	},
	"fish": {
		"label": "Fish",
		"name": "fish",
		"description": "Ingredient",
        "type": CardTypes.CardType.INGREDIENT,
        "sub_type": CardTypes.SubType.VEG,
        "action": CardTypes.Action.MIX,
        "cost": 3,
        "uses": 1,
        "unbreakable": false
	},
    "tomato_slice": {
        "label": "Tomato Slice",
        "name": "tomato_slice",
        "description": "Ingredient",
        "type": CardTypes.CardType.INGREDIENT,
        "sub_type": CardTypes.SubType.VEG,
        "action": CardTypes.Action.MIX,
        "cost": 0,
        "uses": 1,
        "unbreakable": false
    },
    "lettuce_slice": {
        "label": "Lettuce Slice",
        "name": "lettuce_slice",
        "description": "Ingredient",
        "type": CardTypes.CardType.INGREDIENT,
        "sub_type": CardTypes.SubType.VEG,
        "action": CardTypes.Action.MIX,
        "cost": 0,
        "uses": 1,
        "unbreakable": false
    },
    "salad": {
        "label": "Salad",
        "name": "salad",
        "description": """
            SELL for cost\n
            Chop Tomato,\n
			Chop Lettuce,\n
			Mix Sliced Tomato with Sliced Lettuce
        """,
        "requirememts": {
            "tomato_slice": 4,
            "lettuce_slice": 4
        },
        "type": CardTypes.CardType.RECIPE,
        "action": CardTypes.Action.SELL,
        "cost": 4,
        "uses": 1,
        "unbreakable": false
    },
    "shit": {
        "label": "Shit",
        "name": "shit",
        "description": "When you fuck up a MIX",
        "requirememts": {},
        "type": CardTypes.CardType.RECIPE,
        "action": CardTypes.Action.SELL,
        "cost": 0,
        "uses": 1,
        "unbreakable": false
    },
    "fire_spit": {
		"label": "Fire Spit",
		"name": "fire_spit",
        "type": CardTypes.CardType.DEVICE,
		"action": CardTypes.Action.COOK,
        "cost": 5,
        "uses": 1,
        "unbreakable": true,
        "cards_process_max": 1
	},
    "chopping_board": {
        "label": "Chopping Board",
        "name": "chopping_board",
        "description": "CUT ingredients with Knife",
        "type": CardTypes.CardType.DEVICE,
        "sub_type": CardTypes.SubType.NONE,
        "action": CardTypes.Action.CUT,
        "cost": 3,
        "uses": 1,
        "unbreakable": true,
        "cards_process_max": 1
    },
    "counter_top": {
        "label": "Counter Top",
        "name": "counter_top",
        "description": "Store cards on it",
        "type": CardTypes.CardType.DEVICE,
        "sub_type": CardTypes.SubType.NONE,
        "action": CardTypes.Action.STORE,
        "cost": 10,
        "uses": 1,
        "unbreakable": true,
        "cards_process_max": 0
    },
    "bowl": {
        "label": "Chopping Board",
        "name": "chopping_board",
        "description": "CUT ingredients with Knife",
        "type": CardTypes.CardType.DEVICE,
        "action": CardTypes.Action.CUT,
        "cost": 3,
        "uses": 1,
        "unbreakable": true,
        "cards_process_max": 10
    },
    "knife": {
		"label": "Knife",
		"name": "knife",
		"description": "CUT ingredients on Chopping Board",
        "type": CardTypes.CardType.EQUIPMENT,
        "action": CardTypes.Action.CUT,
        "cost": 3,
        "uses": 1,
        "unbreakable": true
	},
	"squeezer": {
		"label": "Squeezer", 
		"name": "squeezer",   
		"description": "SQUEEZE ingredients into a Bowl",
        "type": CardTypes.CardType.EQUIPMENT,
        "action": CardTypes.Action.SQUEEZE,
        "cost": 3,
        "uses": 1,
        "unbreakable": true
	},
    "spoon": {
		"label": "Spoon", 
		"name": "spoon",   
		"description": "MIX ingredients in a Bowl",
        "type": CardTypes.CardType.EQUIPMENT,
        "action": CardTypes.Action.MIX,
        "cost": 2,
        "uses": 1,
        "unbreakable": true
	}
}

var available_recipes = {
	"fish_skewers": {
		"label": "Fish Skewers",
		"name": "fish_skewers",
		"item_required": "cooked_fish_skewer_honey_lemon",
		"steps": [
		],
		"money": 12
	}
}


func generate_id():
    card_id += 1
    return card_id

func get_card(card_name: String):
    return available_cards[card_name]