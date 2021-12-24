extends Node

onready var cards_holder = $Cards/Cards_Holder
onready var enemy_holder = $Enemies
onready var background_track = $BGM
signal change_card_holder_state
signal change_enemy_state

enum {
	PLAYER_TURN,
	GAME_TURN
}

var current_game_state


func _ready():
	pass
	
#func _process(_delta):
#	if (background_track.playing==false):
#			background_track.play();
#	pass

func change_game_state(target_state):
	match target_state:
		PLAYER_TURN:
			for card in range(0, cards_holder.get_child_count()):
				connect("change_card_holder_state", cards_holder.get_child(card), "change_game_state")
				emit_signal("change_card_holder_state", PLAYER_TURN)
			
		GAME_TURN:
			for card in range(0, cards_holder.get_child_count()):
				connect("change_card_holder_state", cards_holder.get_child(card), "change_game_state")
				emit_signal("change_card_holder_state", GAME_TURN)
			for enemy in range(0, enemy_holder.get_child_count()):
				connect("change_enemy_state", enemy_holder.get_child(enemy), "start_moving")
				emit_signal("change_enemy_state")
			$Timer.start()
				
	current_game_state = target_state


func _on_Cards_Holder_change_game_state():
	change_game_state(GAME_TURN)


func _on_Timer_timeout():
	change_game_state(PLAYER_TURN)


func _on_Win_body_entered(body):
	get_tree().change_scene("res://Scenes/WinScreen.tscn")
