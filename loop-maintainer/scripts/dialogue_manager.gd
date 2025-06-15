extends Node

signal dialogue(dialogue_text: String, profile_texture: Texture2D)
signal dialogue_start
signal dialogue_end

@export var start_dialogue: Array[DialogueLine]

func _ready() -> void:
	if get_tree().current_scene.name == "house":
		for line in start_dialogue:
			emit_dialogue(line.text, line.profile)
			await wait_for_dialogue_key()

func emit_dialogue(dialogue_text: String, profile: Texture2D) -> void:
	emit_signal("dialogue", dialogue_text, profile)

func wait_for_dialogue_key() -> void:
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("dialogue"):
			break
