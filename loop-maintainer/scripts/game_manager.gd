extends Node

var should_spawn_obstacles := false
var did_game_start := false
var is_in_dialogue := false
var can_meet_wizard := false

var allow_spike_obstacles := true

var allow_patrol_obstacles := false
var allow_signs := false
var allow_fire_obstacles := false

var did_game_end := false

var player_health := 3

var spike_data: Array = []
var patrol_enemy_data: Array = []
var fire_obstacle_data: Array = []

var next_player_spawn_position: Vector2 = Vector2.INF
var loop_number = 0

func reset_game_state():
	loop_number = 0
	player_health = 3
	next_player_spawn_position = Vector2.INF
	should_spawn_obstacles = false
	is_in_dialogue = false
	did_game_start = false
	can_meet_wizard = false
	allow_spike_obstacles = true
	allow_patrol_obstacles = false
	allow_signs = false
	allow_fire_obstacles = false
	spike_data.clear()
	patrol_enemy_data.clear()
	fire_obstacle_data.clear()
