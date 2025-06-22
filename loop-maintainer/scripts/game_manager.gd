extends Node

var should_spawn_obstacles := false
var did_game_start := false
var is_in_dialogue := false
var can_meet_wizard := false

var allow_spike_obstacles := true

var allow_patrol_obstacles := false
var allow_signs := false
var allow_fire_obstacles := false

var did_game_end := true

var player_health := 3

var spike_data: Array = []
var patrol_enemy_data: Array = []

var next_player_spawn_position: Vector2 = Vector2.INF
var loop_number = 0
