extends Timer

var cruisershot = preload("res://bullets/cruisershot.tscn")
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timeout():
	var c = cruisershot.instantiate()
	self.get_parent().get_parent().add_child(c)
