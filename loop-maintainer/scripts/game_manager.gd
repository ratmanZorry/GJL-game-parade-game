extends Node

var should_spawn_obstacles := false
var did_game_start := false
var is_in_dialogue := false
var can_meet_wizard := false

var next_player_spawn_position: Vector2 = Vector2.INF

var loop_number = 0

func _ready() -> void:
		#await get_tree().create_timer(3).timeout
		#should_spawn_obstacles = true
	pass
