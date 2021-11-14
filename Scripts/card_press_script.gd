extends TextureButton

onready var player = get_node("/root/Game/Player")
onready var cards_holder = get_node("/root/Game/Cards/Cards_Holder")
onready var card_ability_text = $Label
onready var card_ability_text2 = get_node("/root/Game/Card/Label")

signal player_can_move
signal removed_one_card

func _ready():
	connect("player_can_move", player, "card_pressed")
	connect("removed_one_card", cards_holder, "remove_one_card")

func _on_Card_button_down():
	emit_signal("player_can_move")
	emit_signal("removed_one_card")
	queue_free()
	
func set_card_ability():
	var random_int = randi()%3+1
	#each num is different move
	if (random_int==2):
		card_ability_text.set_text("Attack")
	else:	
		card_ability_text.set_text("make 1 move")
