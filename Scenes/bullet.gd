extends CharacterBody2D

# Base Values for Bullet
var speed : float = 50
var damage : int = 1

# Direction is set to 0 so it can be modified in other scripts
var direction : Vector2 = Vector2.ZERO

# Runs every frame
func _physics_process(delta: float) -> void:
	# Set velocity
	velocity = speed * direction
	
	# The function move_and_slide returns True if there is a collision
	# If the bullet collides with an object now, whether its the enemy or a wall, it will break
	if move_and_slide():
		queue_free()

# If a body enters this bullet's Area2D, it will signal this function to run, 
# calling the damage function on that body.
func _on_area_2d_body_entered(body: Node2D) -> void:
	body.damage(damage)
	queue_free()
