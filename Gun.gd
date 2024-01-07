extends Node

@export var bullet: PackedScene
@export var bullet_speed = 30
@export var rateOfFire = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shoot()
	
func shoot():
	var newBullet = bullet.instantiate()
	newBullet.global_transform = $Muzzle.global_transform
	#newBullet.speed = bullet_speed
	var sceneRoot = get_tree().get_root().get_children()[0]
	sceneRoot.add_child(newBullet)
