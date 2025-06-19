extends CharacterBody2D

@export var SPEED = 500.0
var isGoingRight = false

@export var anim: AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_wall():
		isGoingRight = not isGoingRight
		velocity.x = 0
	
	anim.flip_h = !isGoingRight
	
	velocity.x = SPEED * delta if isGoingRight else -SPEED * delta
	
	anim.play("default")
	move_and_slide()
