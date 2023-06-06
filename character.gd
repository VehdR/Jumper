extends CharacterBody2D
# main player

const SPEED = 300.0
const JUMP_VELOCITY = -430.0
var start_pos
signal death
var num_jumps = 0
var attack_timer = 0
var attacking = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	start_pos = position
	$Area2D/SwordHitBox.disabled = true

func _physics_process(delta):
	if Input.is_action_just_pressed("exit_to_menu"):
		get_tree().change_scene_to_file("res://menu.tscn")
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Inputs and conditions
	var direction = Input.get_axis("left", "right")
	var on_floor = is_on_floor()
	var on_wall = is_on_wall()
	var jump_pressed = Input.is_action_just_pressed("jump")
	var attack_pressed = Input.is_action_just_pressed("attack")
	
	# Handle Jump.
	if jump_pressed and ((on_floor or on_wall) or (num_jumps < 1)):
		velocity.y = JUMP_VELOCITY
		num_jumps += 1
		$AnimatedSprite2D.play("jump")
	
	# Get the input direction and handle the movement/deceleration.
	if direction and !attacking:
		velocity.x = direction * SPEED
		if on_floor and !jump_pressed:
			$AnimatedSprite2D.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if on_floor and !jump_pressed and !attacking:
			$AnimatedSprite2D.play("idle")
			
	if attack_pressed:
		$AnimatedSprite2D.play("attack")
		$Area2D/SwordHitBox.disabled = false
		attacking = true
	
	if attacking:
		attack_timer += delta
		
		if attack_timer >= 0.5:
			$Area2D/SwordHitBox.disabled = true
			attacking = false
			attack_timer = 0
			
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true
		
	if on_floor or on_wall:
		num_jumps = 0

	move_and_slide()
	
func die():
	emit_signal("death")
	self.position = start_pos
	velocity = Vector2(0, 0)
	$AnimatedSprite2D.play("idle")

func _on_die_box_player_entered():
	die()

func _on_skeleton_skeleton_attack():
	die()
