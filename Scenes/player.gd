extends CharacterBody2D


const SPEED : float = 150.0
const JUMP_VELOCITY : float = -200.0

@onready var sprite : Sprite2D = $Sprite2D

@export var health : int = 10


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0: # Right
			sprite.flip_h = false
		elif direction < 0: # Left
			sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func damage(value:int) -> void:
	health -= value
	if health < 0:
		print("Game over")
		queue_free()
	else:
		print(health)
