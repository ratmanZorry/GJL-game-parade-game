extends CharacterBody2D

@export var SPEED: float = 100.0
@export var JUMP_VELOCITY: float = -300.0

@export var JUMPBUFFERTIMER: Timer
@export var anim: AnimatedSprite2D

var canBufferJump: bool = false
var was_on_floor: bool = true

func _ready():
	anim.play("idle")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump"):
		JUMPBUFFERTIMER.start()
		canBufferJump = true
	
	if canBufferJump and is_on_floor():
		Jump()
		canBufferJump = false
	
	if Input.is_action_just_released("jump") and not is_on_floor() and velocity.y < 0:
		velocity.y = 0
	
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		anim.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if is_on_floor() and not was_on_floor:
		if direction:
			anim.play("walking")
		else:
			anim.play("idle")

	if is_on_floor():
		if direction:
			anim.play("walking")
		else:
			anim.play("idle")
	else:
		if velocity.y > 0:
			anim.play("falling")
		else:
			anim.play("jumping")

	move_and_slide()
	was_on_floor = is_on_floor()

func Jump():
	velocity.y = JUMP_VELOCITY
	anim.play("jumping")
	JumpLocationManager.jump_locations.append(global_position)

func _on_jump_buffer_timer_timeout() -> void:
	canBufferJump = false
