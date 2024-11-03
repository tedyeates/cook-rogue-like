extends Node

var cut = {
	"lemon": ["lemon slice", 4]
}

var squeeze = {
	"lemon slice": ["lemon juice", 1]
}

func mixAction(ingredient, ingredient2):
	var ingredients = {ingredient: null, ingredient2: null}
	
	if "lemon juice" in ingredients and "honey" in ingredients:
		return ["honey lemon sauce", 1]

func cutAction(ingredient): 
	return cut[ingredient] or []

func squeezeAction(ingredient):
	return squeeze[ingredient] or []
	
var actions = {
	"cut": cutAction,
	"squeeze": squeezeAction,
	"mix": mixAction
}
