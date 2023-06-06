extends CharacterBody2D

enum State {WALK_RIGHT, WALK_LEFT, DYING, REVIVING}

const MOVE_VECTOR = {
	State.WALK_RIGHT: Vector2(100, 0),
	State.WALK_LEFT: Vector2(-100, 0),
	State.DYING: Vector2.ZERO,
	State.REVIVING: Vector2.ZERO,
}

var curstate = State.WALK_RIGHT
var state_time = 0.0
var HEALTH = 1
var hits = 0
signal skeleton_attack
signal skeleton_score

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	switch_to(State.WALK_RIGHT)

func switch_to(new_state: State):
	curstate = new_state
	state_time = 0.0
	
	if new_state == State.WALK_RIGHT:
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = false;
	elif new_state == State.WALK_LEFT:
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = true;
	elif new_state == State.DYING:
		$AnimatedSprite2D.play("die")
	elif new_state == State.REVIVING:
		$AnimatedSprite2D.play_backwards("die")

func _physics_process(delta):
	state_time += delta
	var collide = move_and_collide(MOVE_VECTOR[curstate] * delta)
	
	if collide and curstate == State.WALK_LEFT:
		switch_to(State.WALK_RIGHT)
	elif collide and curstate == State.WALK_RIGHT:
		switch_to(State.WALK_LEFT)
		
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if curstate == State.DYING and state_time >= 1:
		queue_free()
		
	move_and_slide()

func _on_area_2d_area_entered(area):
	if area.is_in_group("GuardRails"):
		if curstate == State.WALK_RIGHT:
			switch_to(State.WALK_LEFT)
		else:
			switch_to(State.WALK_RIGHT)
	else:
		emit_signal("skeleton_attack")


func _on_character_kill_mob():
	emit_signal("skeleton_score")
	switch_to(State.DYING)
