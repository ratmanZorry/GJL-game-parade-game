extends Node2D

@export var house: PackedScene
@export var credits: PackedScene


func _on_start_pressed() -> void:
	SceneController.go_to_house()


func _on_credits_pressed() -> void:
	SceneController.go_to_credits()
