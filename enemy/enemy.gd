extends RigidBody2D

@export
var missle = preload("res://bullets/missle.tscn")

@export
var shimmy = true

@export
var launch_site = Vector2(0.0, -150.0)

@export
var volly_size = 1

@export
var volly_offset = Vector2(0.0, 0.0)

var rng = RandomNumberGenerator.new()
var direction = Vector2(1.0, 0.0)

@export
var health = 2

func _ready():
	$Timer.wait_time += rng.randf_range(-1.0, 3.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	pass

func _on_timer_timeout():
	if multiplayer.is_server():
		for i in range(0, volly_size):
			var m = missle.instantiate()
			m.position = self.position + launch_site + (i*volly_offset)
			self.get_parent().add_child(m)
			await get_tree().create_timer(0.5).timeout
		if shimmy:
			self.linear_velocity *= -1

func _on_hitbox_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if multiplayer.is_server() and area.is_in_group("shot") and area.is_in_group("player_shot"):
		health -= 1
		if health < 1:
			call_deferred("queue_free")
