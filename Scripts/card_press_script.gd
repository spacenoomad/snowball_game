extends TextureButton

onready var player = get_node("/root/Game/Player")
onready var cards_holder = get_node("/root/Game/Cards/Cards_Holder")
onready var card_ability_text = $Label
onready var card_ability_text2 = get_node("/root/Game/Card/Label")

signal player_can_move
signal player_can_attack
signal removed_one_card

var is_attack = false;
var is_move = false;

func _ready():
	connect("player_can_move", player, "card_pressed")
	connect("player_can_attack", player, "card_pressed_attack")
	connect("removed_one_card", cards_holder, "remove_one_card")

func _on_Card_button_down():
	if (is_move): 
		emit_signal("player_can_move")
	else:
		emit_signal("player_can_attack")
		
	emit_signal("removed_one_card")
	queue_free()
	
func set_card_ability():
	var random_int = randi()%3+1
	#each num is different move
	if (random_int==2):
		card_ability_text.set_text("Attack")
		is_attack = true;
	else:	
		card_ability_text.set_text("make 1 move")
		is_move = true;
