extends Node2D

# Get enemy scene for instantiating
var enemy : Resource = preload("res://Scenes/rock_enemy.tscn")

func spawn_enemy() -> void:
	# Create a new instance
	var new_enemy = enemy.instantiate()
	var new_position : Vector2
	
	# Get random number for spawn location
	new_position.x = randi_range(32, get_viewport().content_scale_size.x - 32)
	new_position.y = 32
	print(new_position)
	new_enemy.position = new_position
	
	# Add to scene
	add_child(new_enemy)

func _on_timer_timeout() -> void:
	spawn_enemy()
