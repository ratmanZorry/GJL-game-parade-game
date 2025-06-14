extends Node

var should_spawn_obstacles := false

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	should_spawn_obstacles = true
