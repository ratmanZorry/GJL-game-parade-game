extends Node

signal dialogue(dialogue_text: String, profile_texture: Texture2D)
signal end_dialogue

@export var profiles: Array[Texture2D]

func _ready() -> void:
	emit_dialogue("yo wassup")

func emit_dialogue(dialogue_text: String) -> void:
	emit_signal("dialogue", dialogue_text, profiles[0])
