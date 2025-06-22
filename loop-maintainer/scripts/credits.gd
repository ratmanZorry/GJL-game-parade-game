extends Node2D

@export var main_menu: PackedScene


func _on_back_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu)
