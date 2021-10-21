extends StaticBody2D

export (NodePath) var control_path
onready var control_node = get_node(control_path)

func _ready():
	position = control_node.rect_position
