extends CharacterBody3D

var grav = 9.8
var jump = 5
var move = Vector3()
var hp = 100
var hit_vel = 5.0
const SPEED: int = 7

@onready var hit_rect = $UI/HitRect


func _ready():
	pass

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_right"):
		velocity.x = 0
	elif Input.is_action_pressed("ui_left"):
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x = -SPEED
	else:
		velocity.x = lerpf(velocity.x,0,0.1)
	
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		velocity.z = 0
	elif Input.is_action_pressed("ui_up"):
		velocity.z = SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity.z = -SPEED
	else:
		velocity.z = lerpf(velocity.z,0,0.1)
		
	if not is_on_floor():
		velocity.y -= grav * delta
	move_and_slide()

func hit(dir):
	velocity += dir * hit_vel
	hp = hp - 5
	hitAnimation()
	isDead()
	
func isDead():
	if(hp <= 0):
		gameOver()

# À ajouter
func hitAnimation():
	hit_rect.visible = true
	await get_tree().create_timer(0.2).timeout
	hit_rect.visible = false
	
func gameOver():
	pass
