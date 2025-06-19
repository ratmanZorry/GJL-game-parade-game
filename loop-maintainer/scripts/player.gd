extends CharacterBody2D

@export var SPEED: float = 100.0
@export var JUMP_VELOCITY: float = -300.0

@export var JUMPBUFFERTIMER: Timer
@export var anim: AnimatedSprite2D

@export var ground_cast_1: RayCast2D
@export var ground_cast_2: RayCast2D

@export var camera: Camera2D

var is_sitting := false
@export var can_move := true

var canBufferJump := false
var was_on_floor := true

var is_dead := false

func _ready():
	if GameManager.next_player_spawn_position != Vector2.INF:
		global_position = GameManager.next_player_spawn_position
		GameManager.next_player_spawn_position = Vector2.INF
	anim.play("idle")
	
	if camera:
		camera.position_smoothing_enabled = false
		await get_tree().create_timer(0.2).timeout
		camera.position_smoothing_enabled = true

func _physics_process(delta: float):
	if is_dead:
		return

	is_sitting = GameManager.loop_number == 0 and get_tree().current_scene.name == "house"
	can_move = not is_sitting and not GameManager.is_in_dialogue

	if is_sitting:
		anim.play("sitting")
		return
	
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
	if direction and can_move:
		velocity.x = direction * SPEED
		anim.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if is_on_floor() and not was_on_floor:
		if direction and can_move:
			anim.play("walking")
		else:
			anim.play("idle")

	if is_on_floor():
		if direction and can_move:
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
	if not can_move:
		return
	
	velocity.y = JUMP_VELOCITY
	anim.play("jumping")
	
	if ground_cast_1.is_colliding() and ground_cast_2.is_colliding():
		JumpLocationManager.jump_locations.append(global_position)

func _on_jump_buffer_timer_timeout() -> void:
	canBufferJump = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("kill_hitbox") and not is_dead:
		is_dead = true
		anim.play("death")
		await get_tree().create_timer(0.65).timeout
		anim.queue_free()

func _on_dialogue_manager_dialogue_end() -> void:
	is_sitting = false
	can_move = true
