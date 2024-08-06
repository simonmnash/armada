extends Node2D

@onready var jc: JamConnect = $JamConnect

func _ready():
	pass

func _on_jam_connect_player_disconnected(pid: int, pinfo):
	$Level1.remove_player(pid)

func _on_shoot_button_down():
	var e = InputEventAction.new()
	e.action = &"shoot"
	e.pressed = true
	Input.parse_input_event(e)

func _on_shoot_button_up():
	var e = InputEventAction.new()
	e.action = &"shoot"
	e.pressed = false
	Input.parse_input_event(e)

func _on_right_button_down():
	Input.action_press(&"ui_right")

func _on_right_button_up():
	Input.action_release(&"ui_right")

func _on_left_button_down():
	Input.action_press(&"ui_left")

func _on_left_button_up():
	Input.action_release(&"ui_left")

func _on_jam_connect_player_connected(pid, username):
	$Level1.spawn_player(pid, username)
	$Level1.start_run()

