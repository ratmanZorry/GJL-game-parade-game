extends Node2D

@export var anim: AnimatedSprite2D

func _ready() -> void:
	visible = false


func _on_dialogue_area_body_entered(body: Node2D) -> void:
	print("damn it")
	visible = true
	anim.play("poof_in")
	await get_tree().create_timer(0.55).timeout
	anim.play("idle")
	
