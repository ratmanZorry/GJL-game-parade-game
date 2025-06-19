extends CharacterBody2D

@export var SPEED = 500.0
@export var can_die := true
var is_dead

var isGoingRight = false

@export var anim: AnimatedSprite2D
@export var kill_area: Area2D

func _physics_process(delta: float):
	if is_dead:
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_wall():
		isGoingRight = not isGoingRight
		velocity.x = 0
	
	anim.flip_h = !isGoingRight
	
	velocity.x = SPEED * delta if isGoingRight else -SPEED * delta
	
	anim.play("default")
	move_and_slide()



func _on_death_collider_area_entered(area: Area2D) -> void:
	if can_die and area.is_in_group("player_feet"):
		is_dead = true
		anim.play("dead")
		collision_layer = 0
		collision_mask = 0
		kill_area.queue_free()
