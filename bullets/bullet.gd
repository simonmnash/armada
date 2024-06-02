extends RigidBody2D

@export
var width = 20.0
@export
var height = 20.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if multiplayer.is_server():
		call_deferred("queue_free")


func _on_lifespan_timeout():
	if multiplayer.is_server():
		call_deferred("queue_free")

