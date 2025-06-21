extends Node2D

@export var fountain_lasting_timer: Timer
@export var fountain_timer: Timer

@export var fountain: AnimatedSprite2D
@export var kill_area: Area2D


func _on_fountain_timer_timeout() -> void:
	fountain.visible = true
	kill_area.monitorable = true
	kill_area.monitoring = true
	fountain_lasting_timer.start()


func _on_fountain_lasting_timer_timeout() -> void:
	fountain.visible = false
	kill_area.monitorable = false
	kill_area.monitoring = false
	fountain_timer.start()
