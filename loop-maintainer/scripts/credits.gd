extends Node2D

@export var main_menu: PackedScene


func _on_back_pressed() -> void:
	SceneController.go_to_main_menu()
