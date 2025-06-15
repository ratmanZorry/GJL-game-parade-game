extends Node2D

@export var text: RichTextLabel
@export var profile: Sprite2D
@export var typing_timer: Timer

var full_text := ""
var current_index := 0
var is_typing := false

func _ready() -> void:
	visible = false

func _on_dialogue_manager_dialogue(dialogue_text: String, profile_texture: Texture2D) -> void:
	visible = true
	profile.texture = profile_texture
	full_text = dialogue_text
	current_index = 0
	text.text = ""
	is_typing = true
	typing_timer.start()

func _on_typing_timer_timeout() -> void:
	if current_index < full_text.length():
		text.text += full_text[current_index]
		current_index += 1
	else:
		typing_timer.stop()
		is_typing = false

func skip_typing():
	if is_typing:
		typing_timer.stop()
		text.text = full_text
		is_typing = false

func _on_dialogue_manager_dialogue_end() -> void:
	visible = false
