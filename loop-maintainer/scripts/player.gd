extends CharacterBody2D

@export var SPEED: float = 100.0
@export var JUMP_VELOCITY: float = -300.0

@export var JUMPBUFFERTIMER: Timer
@export var jump_animation_timer: Timer
@export var anim: AnimatedSprite2D

var canBufferJump: bool = false
var current_state: String = "idle"
var was_on_floor: bool = true
var jump_anim_lock: bool = false

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
		jump_anim_lock = false
		if direction:
			set_animation_state("walking")
		else:
			set_animation_state("idle")

	if is_on_floor() and not jump_anim_lock:
		if direction and current_state != "walking":
			set_animation_state("walking")
		elif direction == 0 and current_state != "idle":
			set_animation_state("idle")

	elif not is_on_floor() and not jump_anim_lock and current_state != "jumping":
		set_animation_state("jumping")
	
	if velocity.y > 0 and not is_on_floor():
		anim.play("falling")
	
	move_and_slide()
	was_on_floor = is_on_floor()

func Jump():
	velocity.y = JUMP_VELOCITY
	set_animation_state("jump_start")
	jump_anim_lock = true
	jump_animation_timer.start()

func _on_jump_buffer_timer_timeout() -> void:
	canBufferJump = false

func _on_jump_animation_timer_timeout() -> void:
	jump_anim_lock = false
	set_animation_state("jumping")

func set_animation_state(state: String) -> void:
	if current_state == state:
		return
	current_state = state
	anim.play(state)
