extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 980  # Define gravity as constant

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta  # Use the constant directly

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Handle animations - convert float to Vector2
	handle_animations(Vector2(direction, 0))  # Fixed this line!
	
	move_and_slide()

func handle_animations(direction: Vector2):
	if direction.x == 0:
		animated_sprite.play("Idle")
	elif direction.x > 0:
		animated_sprite.play("RunRight")
	elif direction.x < 0:
		animated_sprite.play("RunLeft")
