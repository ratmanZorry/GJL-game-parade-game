extends CharacterBody2D

@export var SPEED = 500.0
@export var can_die := true
var is_dead

var isGoingRight := false

var can_turn_around := true



@export var anim: AnimatedSprite2D
@export var animator: AnimationPlayer
@export var kill_area: Area2D
@export var ground_cast_1: RayCast2D
@export var ground_cast_2: RayCast2D

@export var turn_around_cooldown: Timer
@export var queue_free_timer: Timer

func _physics_process(delta: float):
	if is_dead:
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
	if not ground_cast_1.is_colliding() or not ground_cast_2.is_colliding() and can_turn_around:
		isGoingRight = not isGoingRight
	
	if is_on_wall() and can_turn_around:
		isGoingRight = not isGoingRight
		can_turn_around = false
		turn_around_cooldown.start()
		velocity.x = 0
	
	anim.flip_h = !isGoingRight
	
	velocity.x = SPEED * delta if isGoingRight else -SPEED * delta
	
	anim.play("default")
	move_and_slide()



func _on_death_collider_area_entered(area: Area2D) -> void:
	if can_die and area.is_in_group("player_feet") and not is_dead:
		is_dead = true
		anim.play("dead")
		collision_layer = 0
		collision_mask = 0
		kill_area.queue_free()
		queue_free_timer.start()
		animator.play("fade")


func _on_queue_free_timer_timeout() -> void:
	queue_free()


func _on_turn_around_cooldown_timeout() -> void:
	can_turn_around = true
