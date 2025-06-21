extends Node2D

var did_spawn_obstacles := false

@export var spike_obstacles: Array[PackedScene]
@export var patrol_enemy_obstacles: Array[PackedScene]
@export var sign_obstacles: Array[PackedScene]
@export var fire_obstacles: Array[PackedScene]

func _ready():
	for data in GameManager.spike_data:
		var index = data["scene_index"]
		var pos = data["position"]
		if index < spike_obstacles.size():
			var scene = spike_obstacles[index]
			var inst = scene.instantiate()
			inst.global_position = pos
			add_child(inst)

	for data in GameManager.patrol_enemy_data:
		var index = data["scene_index"]
		var pos = data["position"]
		if index < patrol_enemy_obstacles.size():
			var scene = patrol_enemy_obstacles[index]
			var inst = scene.instantiate()
			inst.global_position = pos
			add_child(inst)

func _process(delta: float) -> void:
	if GameManager.should_spawn_obstacles and not did_spawn_obstacles:
		for item in JumpLocationManager.jump_locations:
			if GameManager.allow_spike_obstacles and spike_obstacles.size() > 0:
				var spike_index = randi() % spike_obstacles.size()
				var spike_scene = spike_obstacles[spike_index]
				var spike_instance = spike_scene.instantiate()
				spike_instance.global_position = item
				add_child(spike_instance)

				GameManager.spike_data.append({
					"position": item,
					"scene_index": spike_index
				})

			if GameManager.allow_patrol_obstacles and patrol_enemy_obstacles.size() > 0:
				var base_pos = item + Vector2(48, -32)
				var ground_y = get_ground_y(base_pos)
				if ground_y != -1.0:
					var patrol_index = randi() % patrol_enemy_obstacles.size()
					var patrol_scene = patrol_enemy_obstacles[patrol_index]
					var patrol_instance = patrol_scene.instantiate()
					var patrol_pos = Vector2(base_pos.x, ground_y - 50)
					patrol_instance.global_position = patrol_pos
					add_child(patrol_instance)

					GameManager.patrol_enemy_data.append({
						"position": patrol_pos,
						"scene_index": patrol_index
					})

			if GameManager.allow_signs and sign_obstacles.size() > 0:
				var base_pos = item + Vector2(48, -32)
				var ground_y = get_ground_y(base_pos)
				if ground_y != -1.0:
					var sign_index = randi() % sign_obstacles.size()
					var sign_scene = sign_obstacles[sign_index]
					var sign_instance = sign_scene.instantiate()
					var sign_pos = Vector2(base_pos.x, ground_y)
					sign_instance.global_position = sign_pos
					add_child(sign_instance)

			if GameManager.allow_fire_obstacles and fire_obstacles.size() > 0:
				var base_pos = item + Vector2(48, -32)
				var ground_y = get_ground_y(base_pos)
				if ground_y != -1.0:
					var fire_index = randi() % fire_obstacles.size()
					var fire_scene = fire_obstacles[fire_index]
					var fire_instance = fire_scene.instantiate()
					var fire_pos = Vector2(base_pos.x, ground_y)
					fire_instance.global_position = fire_pos
					add_child(fire_instance)

		GameManager.should_spawn_obstacles = false
		did_spawn_obstacles = true

func get_ground_y(start_pos: Vector2, max_distance: int = 64) -> float:
	var space_state = get_viewport().get_world_2d().direct_space_state
	var params = PhysicsRayQueryParameters2D.new()
	params.from = start_pos
	params.to = start_pos + Vector2(0, max_distance)
	params.collision_mask = 1

	var result = space_state.intersect_ray(params)
	if result:
		return result.position.y
	return -1.0
