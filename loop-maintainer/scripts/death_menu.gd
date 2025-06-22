extends Sprite2D

@export var animator: AnimationPlayer
@export var tip_text: RichTextLabel

@export var tips: Array[String]

var did_player_die := false

func _ready() -> void:
	var rand_tip_index = randi_range(0, tips.size())
	tip_text.text = tips[rand_tip_index-1]

func _process(delta: float) -> void:
	if GameManager.player_health <= 0 and not did_player_die:
		await get_tree().create_timer(1).timeout
		did_player_die = true
		animator.play("rize")

func _on_texture_button_button_up() -> void:
	pass
