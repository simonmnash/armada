extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const bullet_scene = preload("res://bullets/lasershot.tscn")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var kills = 0

@export var health = 3:
	set(val):
		health = val
		$Health.value = val

var speed = 10000
var desired_movement := Vector2():
	set(val):
		if desired_movement == val:
			return
		desired_movement = val
		if not multiplayer.has_multiplayer_peer():
			return
		if multiplayer.get_unique_id() == pid:
			#var img := get_viewport().get_texture().get_image()
			#img.save_png("user://test.png")
			send_desired_movement.rpc_id(1, desired_movement)

@rpc("any_peer")
func send_desired_movement(m: Vector2):
	if multiplayer.is_server() and multiplayer.get_remote_sender_id() == pid:
		desired_movement = m

var pid: int
var nametag: String:
	get:
		return $Nametag.text
	set(val):
		$Nametag.text = val


var jump_requested: bool = false

func _ready():
	if multiplayer.get_unique_id() == pid:
		$Camera2D.make_current()

@rpc("any_peer")
func shoot():
	if multiplayer.get_remote_sender_id() != pid:
		return
	jump_requested = true

func _unhandled_input(event):
	if multiplayer.get_unique_id() != pid:
		return
	
	if event.is_action_pressed(&"shoot"):
		if multiplayer.is_server():
			jump_requested = true
		else:
			shoot.rpc_id(1)

func _process(delta):
	if multiplayer.get_unique_id() == pid:
		desired_movement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func _physics_process(delta):
	if not multiplayer.is_server():
		return
	velocity = (desired_movement + Vector2(0.0, -1.0)) * speed * delta
	move_and_slide()

	if jump_requested:
		var b = bullet_scene.instantiate()
		b.get_node("Area2D").add_to_group("player_shot")
		$Guns.add_child(b)
	jump_requested = false

func take_damage(damage):
	if multiplayer.is_server():
		self.health -= damage
		if self.health < 1:
			self.get_parent().get_parent().remove_player(self.pid)
