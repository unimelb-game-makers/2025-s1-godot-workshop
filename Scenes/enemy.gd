extends CharacterBody2D

# Variables
const SPEED:float = 50
var direction:Vector2 = Vector2.RIGHT

# Get sprite to face direction
@onready var sprite := $Sprite2D

# @export allows a value to be adjusted in the "inspector" panel in Godot.
@export var health : int = 3
@export var attack_damage : int = 2

# Runs every frame
func _physics_process(delta: float) -> void:
	# Redirect direction on collision
	# sprite.flip_h is to change the way the enemy is facing based on direction
	if is_on_wall():
		if direction == Vector2.RIGHT:
			direction = Vector2.LEFT
			sprite.flip_h = false
		else:
			direction = Vector2.RIGHT
			sprite.flip_h = true
	
	# Add Gravity
	# delta is the time between this frame and the last frame.
	# Multiplying it here helps keep the game consistent regardless of high/low framerates.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#Move
	velocity.x = SPEED * direction.x
	move_and_slide()
	

# Area2D detects bodies in the "player" layer (which only has the player)
# If contact is made, it signals this function to run to attack the player
func _on_attack_area_body_entered(body: Node2D) -> void:
	body.damage(attack_damage)

# Take damage
func damage(value:int) -> void:
	health -= value
	
	# Die if health is less than or equal to 0
	if health <= 0:
		queue_free()
