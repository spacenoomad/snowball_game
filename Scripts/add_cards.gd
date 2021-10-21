extends HBoxContainer

onready var card = preload("res://Actors/Card.tscn")
var amount_of_cards = 0

enum drawing_cards_states {
	NOTDRAWABLE
	DRAWABLE
}

var drawing_cards_state = drawing_cards_states.DRAWABLE

func _ready():
	randomize()

func generate_cards():
	var random_int = randi()%3+1
	randomize()
	amount_of_cards = random_int
	while random_int > 0:
		add_child(card.instance())
		random_int -= 1

func remove_one_card():
	amount_of_cards -= 1
	if amount_of_cards < 1:
		change_drawing_cards_state(drawing_cards_states.DRAWABLE)

func _on_Button_button_down():
	match drawing_cards_state:
		drawing_cards_states.NOTDRAWABLE:
			pass
		
		drawing_cards_states.DRAWABLE:
			generate_cards()
			change_drawing_cards_state(drawing_cards_states.NOTDRAWABLE)

func change_drawing_cards_state(target_state):
	drawing_cards_state = target_state
