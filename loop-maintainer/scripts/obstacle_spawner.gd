extends Node

var did_spawn_obstacles := false

@export var spike_obstacles: Array[PackedScene]
@export var patroll_enemy_obstacles: Array[PackedScene]

func _ready():
	for data in GameManager.spike_data:
		var index = data["scene_index"]
		var pos = data["position"]
		var scene = spike_obstacles[index]
		var inst = scene.instantiate()
		inst.global_position = pos
		add_child(inst)

	for data in GameManager.patrol_enemy_data:
		var index = data["scene_index"]
		var pos = data["position"]
		var scene = patroll_enemy_obstacles[index]
		var inst = scene.instantiate()
		inst.global_position = pos
		add_child(inst)

func _process(delta: float) -> void:
	if GameManager.should_spawn_obstacles and not did_spawn_obstacles:
		for item in JumpLocationManager.jump_locations:
			var spike_index = randi() % spike_obstacles.size()
			var obstacle_scene = spike_obstacles[spike_index]
			var obstacle_instance = obstacle_scene.instantiate()
			obstacle_instance.global_position = item
			add_child(obstacle_instance)

			GameManager.spike_data.append({
				"position": item,
				"scene_index": spike_index
			})

		GameManager.should_spawn_obstacles = false
		did_spawn_obstacles = true
