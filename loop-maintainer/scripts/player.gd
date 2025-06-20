extends CharacterBody2D

@export var SPEED: float = 100.0
@export var JUMP_VELOCITY: float = -300.0

@export var hurt_time := 0.4


@export var JUMPBUFFERTIMER: Timer
@export var invincibility_timer: Timer
@export var anim: AnimatedSprite2D
@export var animator: AnimationPlayer

@export var ground_cast_1: RayCast2D
@export var ground_cast_2: RayCast2D

@export var camera: Camera2D

var is_sitting := false
@export var can_move := true

var canBufferJump := false
var was_on_floor := true

var is_dead := false

var is_hurt := false
var is_invincible := false

var health = 3

@export var heart_1: Sprite2D
@export var heart_2: Sprite2D
@export var heart_3: Sprite2D

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
	if is_dead or is_hurt:
		return
	
	if is_invincible:
		animator.play("invincible")
	else:
		animator.play("normal")
	
	match health:
		3:
			heart_1.visible = true
			heart_2.visible = true
			heart_3.visible = true	
		2:
			heart_1.visible = true
			heart_2.visible = true
			heart_3.visible = false	
		1:
			heart_1.visible = true
			heart_2.visible = false
			heart_3.visible = false	

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
	if area.is_in_group("kill_hitbox") and not is_invincible and not is_hurt:
		health -= 1
		is_hurt = true
		is_invincible = true
		
		anim.play("hurt")
		
		await get_tree().create_timer(hurt_time).timeout
		
		is_hurt = false
		invincibility_timer.start()
	
	
	if area.is_in_group("instant_death"):
		health = 0
	
	if area.is_in_group("kill_hitbox") and not is_dead and health == 0:
		is_dead = true
		
		heart_1.visible = false
		heart_2.visible = false
		heart_3.visible = false
		
		anim.play("death")
		await get_tree().create_timer(0.65).timeout
		anim.queue_free()

func _on_dialogue_manager_dialogue_end() -> void:
	is_sitting = false
	can_move = true


func _on_invincibility_timer_timeout() -> void:
	is_invincible = false
