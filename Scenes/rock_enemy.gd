extends CharacterBody2D

#Variables
var speed:float = 50
var direction_x:float = 1

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
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Player damaged")
	queue_free()
