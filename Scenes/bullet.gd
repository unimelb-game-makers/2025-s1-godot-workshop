extends CharacterBody2D

var speed : float = 50
var direction : Vector2 = Vector2.ZERO
var damage : int = 1

func _physics_process(delta: float) -> void:
	velocity = speed * direction
	
	if move_and_slide():
		queue_free()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.damage(damage)
	queue_free()
