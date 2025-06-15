extends Area2D

@export var transfer_scene: PackedScene

func _on_body_entered(body: Node2D) -> void:
	if not body is CharacterBody2D:
		return
	set_deferred("monitoring", false)
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_packed(transfer_scene)
