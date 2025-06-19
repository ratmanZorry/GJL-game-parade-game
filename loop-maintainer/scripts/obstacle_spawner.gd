extends Node

var did_spawn_obstacles := false

@export var spike_obstacles: Array[PackedScene]
@export var patrol_enemy_obstacles: Array[PackedScene]



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
		var scene = patrol_enemy_obstacles[index]
		var inst = scene.instantiate()
		inst.global_position = pos
		add_child(inst)

func _process(delta: float) -> void:
	if GameManager.should_spawn_obstacles and not did_spawn_obstacles:
		for item in JumpLocationManager.jump_locations:
			if GameManager.allow_spike_obstacles:
				var spike_index = randi() % spike_obstacles.size()
				var spike_scene = spike_obstacles[spike_index]
				var spike_instance = spike_scene.instantiate()
				spike_instance.global_position = item
				add_child(spike_instance)

				GameManager.spike_data.append({
					"position": item,
					"scene_index": spike_index
				})

			if GameManager.allow_patrol_obstacles:
				var patrol_index = randi() % patrol_enemy_obstacles.size()
				var patrol_scene = patrol_enemy_obstacles[patrol_index]
				var patrol_instance = patrol_scene.instantiate()
				var patrol_pos = item + Vector2(48, 0)
				patrol_instance.global_position = patrol_pos
				add_child(patrol_instance)

				GameManager.patrol_enemy_data.append({
					"position": patrol_pos,
					"scene_index": patrol_index
				})

		GameManager.should_spawn_obstacles = false
		did_spawn_obstacles = true
