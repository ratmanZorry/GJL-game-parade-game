extends Node2D

@export var cheese: Sprite2D
@export var bread: Sprite2D
@export var butter: Sprite2D
@export var juice: Sprite2D

func _ready() -> void:
	if GameManager.loop_number >= 2:
		cheese.visible = true
	else:
		cheese.visible = false

	if GameManager.loop_number >= 4:
		bread.visible = true
	else:
		bread.visible = false
	
	if GameManager.loop_number >= 6:
		butter.visible = true
	else:
		butter.visible = false

	if GameManager.loop_number >= 8:
		juice.visible = true
	else:
		juice.visible = false
