extends Node

signal dialogue(dialogue_text: String, profile_texture: Texture2D)
signal dialogue_end

@export var pre_dialogue_wait_time: float
@export var start_dialogue: Array[DialogueLine]
@onready var dialogue_box: Node2D = get_tree().get_first_node_in_group("dialogue_box")


func _ready() -> void:
	await get_tree().create_timer(pre_dialogue_wait_time).timeout
	for line in start_dialogue:
		emit_signal("dialogue", line.text, line.profile)
		await wait_for_dialogue_key()
	emit_signal("dialogue_end")

func wait_for_dialogue_key() -> void:
	while true:
		if get_tree().process_frame:
			await get_tree().process_frame
			if Input.is_action_just_pressed("dialogue"):
				if dialogue_box.is_typing:
					dialogue_box.skip_typing()
				else:
					break
