extends CharacterBody3D

const SPEED: int = 7

var dir: Vector2i = Vector2i(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	dir.x =  int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")) 
	dir.y =  int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")) 
	if dir.x == 0:
		velocity.x = lerpf(velocity.x, 0 , 0.1)
	else:
		velocity.x = SPEED * dir.x
	if dir.y == 0:
		velocity.z = lerpf(velocity.z, 0 , 0.1)
	else:
		velocity.z = SPEED * dir.y
	move_and_slide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
