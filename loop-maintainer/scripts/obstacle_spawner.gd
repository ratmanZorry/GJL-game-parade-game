extends Node

var did_spawn_obstacles := false

@export var easy_obstacles: Array[PackedScene]

func _process(delta: float) -> void:
	if GameManager.should_spawn_obstacles and not did_spawn_obstacles:
		for item in JumpLocationManager.jump_locations:
			var obstacle_scene = easy_obstacles.pick_random()
			var obstacle_instance = obstacle_scene.instantiate()
			obstacle_instance.global_position = item
			add_child(obstacle_instance)
			GameManager.should_spawn_obstacles = false
