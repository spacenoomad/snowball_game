extends KinematicBody2D

export var _speed = 0

enum button_states {
	HIDDEN,
	NOTHOVER,
	HOVER
}

enum player_states {
	IDLE,
	MOVING
}

var target_position = Vector2()
var current_button_state = button_states.HIDDEN
var current_player_state = player_states.IDLE

func _process(_delta):
	match_button_states()
	match_player_states()

func match_player_states():
	match current_player_state:
		player_states.IDLE:
			pass
		
		player_states.MOVING:
			move_towards_target(target_position)

func match_button_states():
	
	match current_button_state:
	
		button_states.HIDDEN:
			pass
		
		button_states.NOTHOVER:
			pass
		
		button_states.HOVER:
			if Input.is_action_pressed("left_click"):
				change_player_state(player_states.MOVING)
				change_button_state(button_states.HIDDEN)

func move_towards_target(local_target_position):
	position = position.move_toward(local_target_position, _speed)
	if local_target_position == position:
		change_player_state(player_states.IDLE)

func change_player_state(target_state):
	current_player_state = target_state

func change_button_state(target_state):
	current_button_state = target_state

func card_pressed():
	change_button_state(button_states.NOTHOVER)

func _on_Button_1_mouse_entered():
	if current_button_state == button_states.NOTHOVER:
		change_button_state(button_states.HOVER)
	target_position = get_child(2).get_child(0).global_position

func _on_Button_1_mouse_exited():
	if current_button_state == button_states.HOVER:
		change_button_state(button_states.NOTHOVER)


func _on_Button_2_mouse_entered():
	if current_button_state == button_states.NOTHOVER:
		change_button_state(button_states.HOVER)
	target_position = get_child(2).get_child(1).global_position

func _on_Button_2_mouse_exited():
	if current_button_state == button_states.HOVER:
		change_button_state(button_states.NOTHOVER)


func _on_Button_3_mouse_entered():
	if current_button_state == button_states.NOTHOVER:
		change_button_state(button_states.HOVER)
	target_position = get_child(2).get_child(2).global_position

func _on_Button_3_mouse_exited():
	if current_button_state == button_states.HOVER:
		change_button_state(button_states.NOTHOVER)


func _on_Button_4_mouse_entered():
	if current_button_state == button_states.NOTHOVER:
		change_button_state(button_states.HOVER)
	target_position = get_child(2).get_child(3).global_position

func _on_Button_4_mouse_exited():
	if current_button_state == button_states.HOVER:
		change_button_state(button_states.NOTHOVER)
