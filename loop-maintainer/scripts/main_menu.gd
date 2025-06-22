extends Node2D

@export var house: PackedScene
@export var credits: PackedScene


func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(house)


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_packed(credits)
