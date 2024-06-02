extends Node2D

const eg_scene = preload("res://enemy/enemy.tscn")

func _ready():
	var e = eg_scene.instantiate()
	if multiplayer.is_server():
		add_child(e)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
