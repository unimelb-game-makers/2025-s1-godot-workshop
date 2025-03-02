extends Node2D

# Get player position
@onready var player := $Player
# Get enemy scene for instantiating
var enemy : Resource = preload("res://Scenes/rock_enemy.tscn")

func spawn_enemy() -> void:
	# Create a new instance
	var new_enemy = enemy.instantiate()
	var new_position : Vector2
	
	# Get random number for spawn location
	var viewport_size = get_viewport().size
	new_position.x = randi_range(16, viewport_size.x - 16)
	new_position.y = 0
	new_enemy.position = new_position
	
	# Add to scene
	add_child(new_enemy)


func _ready() -> void:
	spawn_enemy()
