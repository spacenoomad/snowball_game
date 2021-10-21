extends TextureButton

onready var player = get_node("/root/Game/Player")
onready var cards_holder = get_node("/root/Game/Cards/Cards_Holder")

signal player_can_move
signal removed_one_card

func _ready():
	connect("player_can_move", player, "card_pressed")
	connect("removed_one_card", cards_holder, "remove_one_card")

func _on_Card_button_down():
	emit_signal("player_can_move")
	emit_signal("removed_one_card")
	queue_free()
