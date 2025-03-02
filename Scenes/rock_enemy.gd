extends CharacterBody2D

#Variables
var speed:float = 50
var direction_x:float = 1

# @export allows a value to be adjusted in the "inspector" panel in Godot.
@export var health : int = 3
@export var attack_damage : int = 2

#Runs every frame
func _physics_process(delta: float) -> void:
	#Redirect direction on collision
	if is_on_wall():
		direction_x *= -1
	
	#Add Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#Move
	velocity.x = speed * direction_x
	move_and_slide()
	

# Area2D detects bodies in the "player" layer (which only has the player)
# If contact is made, it signals this function to run to attack the player
func _on_area_2d_body_entered(body: Node2D) -> void:
	body.damage(attack_damage)

# Take damage
func damage(value:int) -> void:
	health -= value
	if health <= 0:
		queue_free()
