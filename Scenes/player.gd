extends CharacterBody2D

# Movement variables
const SPEED : float = 150.0
const JUMP_VELOCITY : float = -200.0
var facing_right : bool = true

# "Calls" a child of this node so its parameters can be directly adjusted
# @onready tells the script to assign this value when this scene is initialised;
# A scene cannot access it's children before it is initialised
@onready var sprite := $AnimatedSprite2D

# @export allows a value to be adjusted in the "inspector" panel in the property window in Godot.
@export var health : int = 10

# Get bullet scene so it can be instantiated later
# preload() converts a filepath string into a resource
var bullet : Resource = preload("res://Scenes/bullet.tscn")

# Runs every frame
func _physics_process(delta: float) -> void:
	# Add the gravity.
	# delta is the time between this frame and the last frame.
	# Multiplying it here helps keep the game consistent regardless of high/low framerates.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Handle shooting
	if Input.is_action_just_pressed("Shoot"):
		shoot()

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("MoveLeft", "MoveRight")
	
	# direction is (0,0) if nothing is being pressed.
	# This if statement will run if direction does not equal to (0,0)
	if direction:
		velocity.x = direction * SPEED
		# Flip sprite based on direction
		sprite.animation = "Run"
		if direction > 0: # Right
			facing_right = true
			sprite.flip_h = false
		elif direction < 0: # Left
			facing_right = false
			sprite.flip_h = true
	# Deceleration if no input button is pressed
	else:
		sprite.animation = "Idle"
		# move_toward is a function which slowly changes a value from one to another over time.
		# This helps for acceleration/deceleration to make your game feel smooth like butter.
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Function to move player
	move_and_slide()

# Take damage and see if player is still alive
func damage(value:int) -> void:
	health = health - value
	if health <= 0:
		print("Game over")
		queue_free()
	else:
		print(health)

# Create new bullet
func shoot() -> void:
	# Create bullet and adjust parameters
	var new_bullet = bullet.instantiate()
	# Sets the bullets position to the player position
	# global_position takes the player's position relative to the scene they're in
	new_bullet.position = global_position
	if facing_right:
		new_bullet.direction = Vector2.RIGHT
	else:
		new_bullet.direction = Vector2.LEFT
	
	# Spawns the bullet into the scene the player is in
	get_parent().add_child(new_bullet)
	pass
