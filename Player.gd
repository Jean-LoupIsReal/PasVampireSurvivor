extends CharacterBody3D

var hp = 100

const SPEED: int = 7

@export var bullet_speed = 25
@onready var bullet_scene = preload("res://bullet.tscn")
@onready var bullet_spawn_Point = $Camera3D/BulletSpawn

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
	move_and_slide()
	
	if Input.is_action_pressed("shoot"):
		shoot()

func hit(damage):
	hp = hp - damage
	hitAnimation()
	isDead()
	
func isDead():
	if(hp <= 0):
		gameOver()

# À ajouter
func hitAnimation():
	pass
	
func gameOver():
	pass

func shoot():
	var projectile = bullet_scene.instantiate()
	
	add_sibling(projectile)# add the projectile to the scene
	
	#handle movement and direction
	projectile.transform = bullet_spawn_Point.global_transform
	projectile.linear_velocity = bullet_spawn_Point.global_transform.basis.z * -1 * bullet_speed
