extends CharacterBody2D

# Base Values for Bullet
var speed : float = 100
var damage : int = 1

# Access animations
@onready var animation_player := $AnimationPlayer
@onready var collision_shape := $CollisionShape2D
@onready var area2d_collision_shape := $Area2D/CollisionShape2D

# Direction is set to 0 so it can be modified in other scripts
var direction : Vector2 = Vector2.ZERO

# Runs every frame
func _physics_process(_delta: float) -> void:
	# Set velocity
	velocity = speed * direction
	
	# The function move_and_slide returns True if there is a collision
	# If the bullet collides with an object now, whether its the enemy or a wall, it will break
	if move_and_slide():
		break_bullet()

# If a body enters this bullet's Area2D, it will signal this function to run, 
# calling the damage function on that body.
func _on_area_2d_body_entered(body: Node2D) -> void:
	body.damage(damage)
	break_bullet()

func break_bullet() -> void:
	# Stop detecting collisions
	collision_shape.set_deferred("disabled", true)
	area2d_collision_shape.set_deferred("disabled", true)
	animation_player.play("Break")
	
