extends Node


func _on_dialogue_manager_dialogue_end() -> void:
	GameManager.can_meet_wizard = true
