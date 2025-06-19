extends Node

var should_spawn_obstacles := false
var did_game_start := false
var is_in_dialogue := false
var can_meet_wizard := false
var allow_patrol_obstacles := false
#var allow_flying_obstacles := false  # example for future types

var spike_data: Array = []
var patrol_enemy_data: Array = []

var next_player_spawn_position: Vector2 = Vector2.INF
var loop_number = 0
