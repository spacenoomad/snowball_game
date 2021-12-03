extends RigidBody2D


func _on_Area2D_area_entered(area):
	area.get_parent().queue_free()
	queue_free()
