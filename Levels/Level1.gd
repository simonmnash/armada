extends Node2D

var character_scn = preload("res://Character.tscn")
var started = false
const eg_scene = preload("res://enemy/enemy.tscn")
const cruiser_scene = preload("res://enemy/cruiser.tscn")
var rng = RandomNumberGenerator.new()
func spawn_player(pid: int, nametag: String, player_data):
	var p: CharacterBody2D = character_scn.instantiate()
	p.pid = pid
	p.nametag = nametag
	if len($Players.get_children()) < 1:
		p.position = $SpawnPoints.get_children().pick_random().position
	else:
		p.position = $Players.get_children().pick_random().position + Vector2(randf_range(-200.0, 200.0), 400.0)
	p.name = str(pid)
	$Players.add_child(p, true)
	p.set_player_data(player_data)

func remove_player(pid):
	var p = $Players.get_node(str(pid))
	if p != null:
		p.queue_free()

func get_players():
	return $Players.get_children()
	
func start_run():
	if not started:
		add_enemy()
		started = true
		
func add_enemy():
	if multiplayer.is_server():
		var c = cruiser_scene.instantiate()
		c.position = $Cruiser.position
		$Enemies.add_child(c)
		for i in [-800.0, -500.0, -200.0, 0.0, 200.0, 500.0]:
			for j in [-1000, -500, 0, 500, 1000]:
				var e = eg_scene.instantiate()
				e.position = Vector2(i+rng.randf_range(-50.0, 50.0), i+j+rng.randf_range(-50, 50))
				$Enemies.add_child(e)
		
		for i in [-800.0, -500.0, -200.0, 0.0, 200.0, 500.0]:
			for j in [-1000, -500, 0, 500, 1000]:
				var e = eg_scene.instantiate()
				e.position = Vector2(i+rng.randf_range(-50.0, 50.0), i+j+rng.randf_range(-50, 50))
				$Enemies2.add_child(e)
