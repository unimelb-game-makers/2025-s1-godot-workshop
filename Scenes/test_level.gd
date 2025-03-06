extends Node2D

# Get enemy scene for instantiating
# The .tscn file extension is for scenes
# preload() converts a string filepath to a resource
var enemy : Resource = preload("res://Scenes/enemy.tscn")

func spawn_enemy() -> void:
	# Create a new instance of the enemy
	var new_enemy = enemy.instantiate()
	var new_position : Vector2
	
	# Get random number for spawn location
	# randi_range(min,max) returns a randon integer between the min and max value
	# get_viewport().content_scale_size gets the size of the screen area the camera sees before scaling
	new_position = Vector2(randi_range(32, get_viewport().content_scale_size.x - 32), 32)
	#print(new_position)
	new_enemy.position = new_position
	
	# Add to scene
	$"EnemyFolder".add_child(new_enemy)

# Receives a signal from the Timer node everytime it finishes
func _on_timer_timeout() -> void:
	spawn_enemy()
