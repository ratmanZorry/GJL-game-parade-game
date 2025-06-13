extends CharacterBody2D

@export var head: AnimatedSprite2D
@export var body: AnimatedSprite2D
@export var arms: AnimatedSprite2D
@export var legs: AnimatedSprite2D

@export var gravity = 300.0

@export var speed := 100.0

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity
	
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
