extends CharacterBody2D

# Base Values for Bullet
const SPEED : float = 100
const DAMAGE : int = 1

# Access children to adjust animations and collisions
@onready var animation_player := $AnimationPlayer
@onready var collision_shape := $CollisionShape2D
@onready var attack_area_collision_shape := $AttackArea/CollisionShape2D

# Direction is set to 0 so it can be modified in the player script
var direction : Vector2 = Vector2.ZERO

# _physics_process runs every frame
# The variable delta measures the time between the current frame and the last frame.
# It is useful for cases where you don't want gameplay to be affected by framerate.
# We add an underscore in front of delta to show that we are not using it.
func _physics_process(_delta: float) -> void:
	# Set velocity
	velocity = SPEED * direction
	
	# The function move_and_slide returns True if there is a collision
	# If the bullet collides with an object now, whether its the enemy or a wall, it will break
	if move_and_slide():
		break_bullet()

# If a body enters this bullet's Area2D, it will signal this function to run, 
# calling the damage function on that body.
func _on_attack_area_body_entered(body: Node2D) -> void:
	body.damage(DAMAGE)
	break_bullet()

# Function to make bullet disappear.
func break_bullet() -> void:
	# Stop detecting collisions - so the bullet doesn't continue hitting enemies after the first one
	collision_shape.set_deferred("disabled", true)
	attack_area_collision_shape.set_deferred("disabled", true)
	
	# Play an animation which shows the bullet breaking
	animation_player.play("Break")
	
