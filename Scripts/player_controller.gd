extends KinematicBody2D

var bullet = preload("res://Actors/Bullet.tscn")
onready var counter = get_node("/root/Game/MovesCountText")
export var _speed = 0
export var bullet_speed = 1000;
var moves_left =10
var has_attacked = false;
var current_move_attack=false;
onready var bullet_spawn_point = $bulletSpawner


enum button_states {
	HIDDEN,
	NOTHOVER,
	HOVER
}

enum player_states {
	IDLE,
	MOVING, 
	ATTACK
}

var target_position = Vector2()
var bullet_rotation = null;
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
			
		player_states.ATTACK:
			attack_towards_target(target_position, bullet_rotation)
			

func match_button_states():
	
	match current_button_state:
	
		button_states.HIDDEN:
			pass
		
		button_states.NOTHOVER:
			pass
		
		button_states.HOVER:
			if Input.is_action_pressed("left_click"):
				if (current_move_attack): 
					change_player_state(player_states.ATTACK)
					change_button_state(button_states.HIDDEN)
					current_move_attack=false;
					has_attacked = false;
					
					
					
				else:
					change_player_state(player_states.MOVING)
					change_button_state(button_states.HIDDEN)
					
					
					
				

func move_towards_target(local_target_position):
	position = position.move_toward(local_target_position, _speed)
	if local_target_position == position:
		change_player_state(player_states.IDLE)
		moves_left-=1;
		counter.set_text(str(moves_left));

var bullet_instance;
func attack_towards_target(local_target_position, bullet_rotation):
	shoot(local_target_position, bullet_rotation);
#	shoot in direction
	change_player_state(player_states.IDLE)

func shoot( target, dir):
	if (!has_attacked):
		has_attacked = true;
		bullet_instance = bullet.instance()
		bullet_instance.position = get_global_position();
		bullet_instance.apply_impulse(Vector2(1,0), Vector2(500, 0).rotated(deg2rad(dir)));
		get_tree().get_root().add_child(bullet_instance);


func change_player_state(target_state):
	current_player_state = target_state

func change_button_state(target_state):
	current_button_state = target_state

func card_pressed():
	change_button_state(button_states.NOTHOVER)
	current_move_attack = false;

func card_pressed_attack():
	current_move_attack = true;
	change_button_state(button_states.NOTHOVER)
	
	
	
func _on_Button_1_mouse_entered():
	if current_button_state == button_states.NOTHOVER:
		change_button_state(button_states.HOVER)
	bullet_rotation = 0
		
	target_position = get_child(2).get_child(0).global_position

func _on_Button_1_mouse_exited():
	if current_button_state == button_states.HOVER:
		change_button_state(button_states.NOTHOVER)


func _on_Button_2_mouse_entered():
	if current_button_state == button_states.NOTHOVER:
		change_button_state(button_states.HOVER)
	target_position = get_child(2).get_child(1).global_position
	bullet_rotation = 90

func _on_Button_2_mouse_exited():
	if current_button_state == button_states.HOVER:
		change_button_state(button_states.NOTHOVER)


func _on_Button_3_mouse_entered():
	if current_button_state == button_states.NOTHOVER:
		change_button_state(button_states.HOVER)
	target_position = get_child(2).get_child(2).global_position
	bullet_rotation = 270

func _on_Button_3_mouse_exited():
	if current_button_state == button_states.HOVER:
		change_button_state(button_states.NOTHOVER)


func _on_Button_4_mouse_entered():
	if current_button_state == button_states.NOTHOVER:
		change_button_state(button_states.HOVER)
	target_position = get_child(2).get_child(3).global_position
	bullet_rotation = 180
	

func _on_Button_4_mouse_exited():
	if current_button_state == button_states.HOVER:
		change_button_state(button_states.NOTHOVER)
