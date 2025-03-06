extends CharacterBody2D

# Base Values for Bullet
var speed : float = 100
var damage : int = 1

# Direction is set to 0 so it can be modified by the player's direction later on
var direction : Vector2 = Vector2.ZERO

# _physics_process runs every frame
# The variable delta measures the time between the current frame and the last frame.
# It is useful for cases where you don't want gameplay to be affected by framerate.
# We add an underscore in front of delta to show that we are not using it.
func _physics_process(_delta: float) -> void:
	# Set velocity
	velocity = speed * direction
	
	# The function move_and_slide returns True if there is a collision
	# If the bullet collides with an object now, whether its the enemy or a wall, it will break
	if move_and_slide():
		break_bullet()

# If a body enters this bullet's attack area, it will signal this function to run, 
# calling the damage function on that body.
func _on_attack_area_body_entered(body: Node2D) -> void:
	body.damage(damage)
	break_bullet()

# Function to make bullet disappear.
# Good to keep it separate in case we want to adjust what happens when the bullet breaks later on.
# Eg, add animations, knockback, area of effect damage, etc.
func break_bullet() -> void:
	# Bullet disappears
	queue_free()
