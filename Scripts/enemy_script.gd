extends KinematicBody2D

var go_right = null
var go_down = null
var go_left = null
var go_up = null

var target_position

var _speed = 5

enum {
	IDLE,
	MOVING
}

var enemy_state = IDLE

func _physics_process(delta):
	match(enemy_state):
		IDLE:
			pass
		MOVING:
			position = position.move_toward(target_position, _speed)
			if position == target_position:
				change_state(IDLE)

func change_state(target_state):
	match(target_state):
		IDLE:
			pass
		MOVING:
			target_position = null
			while(target_position == null):
				roll_target_cube()
	enemy_state = target_state

func roll_target_cube():
	randomize()
	var pick_path = randi()%4+1
	match(pick_path):
		1:
			target_position = go_right
		2:
			target_position = go_down
		3:
			target_position = go_left
		4:
			target_position = go_up

func start_moving():
	change_state(MOVING)

func _on_Sensor_1_body_entered(body):
	go_right = body.get_global_position()
	if body.get_collision_layer_bit(4):
		go_right = null


func _on_Sensor_2_body_entered(body):
	go_down = body.get_global_position()
	if body.get_collision_layer_bit(4):
		go_down = null


func _on_Sensor_3_body_entered(body):
	go_left = body.get_global_position()
	if body.get_collision_layer_bit(4):
		go_left = null


func _on_Sensor_4_body_entered(body):
	go_up = body.get_global_position()
	if body.get_collision_layer_bit(4):
		go_up = null


func _on_Sensor_4_body_exited(body):
	go_up = null
	if body.get_collision_layer_bit(4):
		go_up = null

func _on_Area2D_body_entered(body):
	print('change to lose screen')
