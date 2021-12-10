extends HBoxContainer

onready var card = preload("res://Actors/Card.tscn")
var amount_of_cards = 0
#var moves_left = 10;
onready var draw_cards_sfx = $DrawSFX

signal change_game_state()

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
		var new_card = card.instance()
		add_child(new_card)
		new_card.set_card_ability()
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
			emit_signal("change_game_state")
			$DrawSFX.play();

func change_drawing_cards_state(target_state):
	drawing_cards_state = target_state
