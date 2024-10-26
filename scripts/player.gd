extends CharacterBody2D

@export var pathTarget : Node2D

var speed = 3000

@onready var navigationAgent = $Navigation/NavigationAgent2D


func _physics_process(delta):
	calculate_z_index()
	var direction = Vector2.ZERO
	if pathTarget:
		if navigationAgent.is_navigation_finished():
			pathTarget = null
		else:
			direction = (navigationAgent.get_next_path_position() - global_position).normalized()
			velocity.x = direction.x * speed * delta
			velocity.y = direction.y * speed * delta * 0.5
			
			move_and_slide()

func calculate_z_index():
	var z_index_bonus = 0
	var base_z_index = 4
	
	var tile_pos = get_parent().get_node("TileMap").local_to_map(global_position)
	z_index_bonus = tile_pos.x + tile_pos.y
	z_index = base_z_index + z_index_bonus
	


func _on_timer_timeout():
	if pathTarget:
		navigationAgent.target_position = pathTarget.global_position + Vector2(0, -25)
