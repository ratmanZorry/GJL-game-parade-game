extends Node

signal dialogue(dialogue_text: String, profile_texture: Texture2D)
signal dialogue_end

@export var pre_dialogue_wait_time: float
@export var pre_WIZARD_dialogue_wait_time: float = 0.275
@export var start_dialogue: Array[loop_dialogue_number]
@export var dialogue_2: Array[loop_dialogue_number]
@export var dialogue_3: Array[loop_dialogue_number]
@export var dialogue_4: Array[loop_dialogue_number]
@export var dialogue_5: Array[loop_dialogue_number]

@export_category("wizard dialogues")
@export var wizard_dialogue_1: Array[loop_dialogue_number]
@export var wizard_dialogue_2: Array[loop_dialogue_number]
@export var wizard_dialogue_3: Array[loop_dialogue_number]
@export var wizard_dialogue_4: Array[loop_dialogue_number]
@export var wizard_dialogue_5: Array[loop_dialogue_number]


@export var dialogue_area: Area2D

@onready var dialogue_box: Node2D = get_tree().get_first_node_in_group("dialogue_box")


func _ready() -> void:
	await get_tree().create_timer(pre_dialogue_wait_time).timeout

	for block in start_dialogue:
		if block.loop_number == GameManager.loop_number:
			for line in block.lines:
				GameManager.is_in_dialogue = true
				emit_signal("dialogue", line.text, line.profile)
				await wait_for_dialogue_key()
			GameManager.is_in_dialogue = false
			emit_signal("dialogue_end")
			GameManager.loop_number += 1
			print(GameManager.loop_number)
			return

func wait_for_dialogue_key() -> void:
	while true:
		if get_tree().process_frame:
			await get_tree().process_frame
			if Input.is_action_just_pressed("dialogue"):
				if dialogue_box.is_typing:
					dialogue_box.skip_typing()
				else:
					break


func _on_dialogue_area_body_entered(body: Node2D) -> void:
	if dialogue_area and dialogue_area.is_in_group("wizard_dialogue_area"):
		if GameManager.can_meet_wizard:
			await get_tree().create_timer(pre_WIZARD_dialogue_wait_time).timeout
			GameManager.can_meet_wizard = false
			for block in wizard_dialogue_1:
				if block.loop_number == GameManager.loop_number:
					for line in block.lines:
						GameManager.is_in_dialogue = true
						emit_signal("dialogue", line.text, line.profile)
						await wait_for_dialogue_key()
					GameManager.is_in_dialogue = false
					emit_signal("dialogue_end")
					GameManager.should_spawn_obstacles = true
					return
