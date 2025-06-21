extends Area2D

@export var transfer_scene_path: String
var transfer_scene: PackedScene

@export var transfer_position: Vector2

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	print("Loading scene path:", transfer_scene_path)
	transfer_scene = load(transfer_scene_path)
	if transfer_scene == null:
		print("Failed to load scene:", transfer_scene_path)
		return

	GameManager.next_player_spawn_position = transfer_position
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_packed(transfer_scene)

	set_deferred("monitoring", false)
