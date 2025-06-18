extends Node2D

@export var anim: AnimatedSprite2D

func _ready() -> void:
	self.visible = false


func _on_dialogue_area_body_entered(body: Node2D) -> void:
	if GameManager.can_meet_wizard:
		print("damn it")
		self.visible = true
		anim.play("poof_in")
		await get_tree().create_timer(0.275).timeout
		anim.play("idle")
	


func _on_dialogue_manager_dialogue_end() -> void:
		anim.play("poof_out")
		await get_tree().create_timer(0.275).timeout
		visible = false
