extends CharacterBody2D

# How fast the student moves
@export var patrol_speed = 100.0
# How far the student moves before turning around
@export var patrol_distance = 150.0

# Internal variables
var start_x
var moving_right = true
var can_shred = true

func _ready():
	# Remember where we started
	start_x = position.x
	# Connect the area's signal to detect when player enters
	$Area2D.body_entered.connect(_on_player_entered)

func _physics_process(delta):
	# Decide which direction to move
	if moving_right:
		velocity.x = patrol_speed
	else:
		velocity.x = -patrol_speed
	
	# Check if we've gone too far and need to turn around
	if position.x > start_x + patrol_distance:
		moving_right = false
	if position.x < start_x - patrol_distance:
		moving_right = true
	
	# Actually move the student
	move_and_slide()

func _on_player_entered(body):
	# Check if it's the player and if we can shred
	if body.name == "Player" and can_shred:
		shred_shirt(body)

func shred_shirt(player):
	# Prevent multiple rapid shreddings
	can_shred = false
	
	# Use the global SignalBus
	SignalBus.shirt_shredded.emit("Student tore your shirt! -$50")
	print("Student emitted shred signal")
	
	# Cooldown before can shred again
	await get_tree().create_timer(1.0).timeout
	can_shred = true
