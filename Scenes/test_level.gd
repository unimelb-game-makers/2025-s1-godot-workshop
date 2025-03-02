extends Node2D


@onready var player := $Player
var enemy : Resource = preload("res://Scenes/rock_enemy.tscn")

func spawn_enemy() -> void:
	var new_enemy = enemy.instantiate()
	var new_position : Vector2
	var viewport_size = get_viewport().size
	new_position.x = randi_range(16, viewport_size.x - 16)
	new_position.y = 0
	new_enemy.position = new_position
	add_child(new_enemy)


func _ready() -> void:
	spawn_enemy()
