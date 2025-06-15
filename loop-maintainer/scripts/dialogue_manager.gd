extends Node

signal dialogue(dialogue_text: String, profile_texture: Texture2D)
signal dialogue_end

@export var start_dialogue: Array[DialogueLine]
@export var dialogue_box: Node2D


func _ready() -> void:
	if get_tree().current_scene.name == "house":
		for line in start_dialogue:
			emit_signal("dialogue", line.text, line.profile)
			await wait_for_dialogue_key()
		emit_signal("dialogue_end")

func wait_for_dialogue_key() -> void:
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("dialogue"):
			if dialogue_box.is_typing:
				dialogue_box.skip_typing()
			else:
				break
