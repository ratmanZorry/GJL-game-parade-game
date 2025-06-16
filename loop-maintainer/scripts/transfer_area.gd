extends Area2D

@export var transfer_scene_path: String
var transfer_scene: PackedScene

@export var transfer_position: Vector2

func _on_body_entered(body: Node2D) -> void:
	
	transfer_scene = load(transfer_scene_path)
	if not body is CharacterBody2D:
		return

	if transfer_scene_path == null:
		print("no scene path was entered")

	if body.is_in_group("player"):
		GameManager.next_player_spawn_position = transfer_position
		await get_tree().create_timer(0.1).timeout
		get_tree().change_scene_to_packed(transfer_scene)

	set_deferred("monitoring", false)
