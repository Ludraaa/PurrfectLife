extends CharacterBody2D

var tilePos : Vector2i
var targetPos : Vector2i
const speed = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	
	#temporary
	targetPos = Vector2i(0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	tilePos = get_parent().local_to_map(position)
	#print("curr tilepos: ", tilePos)
	if (tilePos != targetPos):
		#print(abs(targetPos.x - tilePos.x) < abs(targetPos.y - tilePos.y))
		if (abs(targetPos.x - tilePos.x) <= abs(targetPos.y - tilePos.y)):
			#print(targetPos.y - tilePos.y < 0)
			if (targetPos.y - tilePos.y < 0):
				position.x += speed * delta
				position.y -= speed * delta * 0.5
			else:
				position.x -= speed * delta
				position.y += speed * delta * 0.5
		else:
			if (targetPos.x - tilePos.x < 0):
				position.x -= speed * delta
				position.y -= speed * delta * 0.5
			else:
				position.x += speed * delta
				position.y += speed * delta * 0.5
	
	move_and_slide()
