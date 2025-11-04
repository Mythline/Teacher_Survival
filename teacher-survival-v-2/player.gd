extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 980

# Add a variable to track if we're jumping
var is_jumping = false
# Add variable to track facing direction
var facing_right = true

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		# Reset jump state when we land
		is_jumping = false

	# Get input direction FIRST so we can use it for jump animation
	var direction := Input.get_axis("ui_left", "ui_right")
	
	# Update facing direction when moving
	if direction != 0:
		facing_right = direction > 0
	
	# Handle jump - MODIFIED SECTION
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		
		# Set flip based on facing direction FIRST
		animated_sprite.flip_h = !facing_right
		
		# Play jump animation (same for both directions, just flipped)
		animated_sprite.play("Jump")

	# Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Only handle normal animations if we're NOT jumping
	if not is_jumping:
		handle_animations(Vector2(direction, 0), facing_right)
	
	move_and_slide()

func handle_animations(direction: Vector2, facing_right: bool):
	# Set flip based on facing direction (true = right, false = left)
	animated_sprite.flip_h = !facing_right
	
	if direction.x == 0:
		animated_sprite.play("Idle")
	elif direction.x > 0:
		animated_sprite.play("RunRight")
	elif direction.x < 0:
		animated_sprite.play("RunRight")  # Use the same RunRight animation, just flipped
