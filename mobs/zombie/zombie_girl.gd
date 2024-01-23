extends CharacterBody3D

var player = null
var stateMachine
const SPEED = 4.0
const attackRange = 1.5
var dm = 5

@export var player_path : NodePath

@onready var nav_agent = $NavigationAgent3D
@onready var anim_tree = $AnimationTree


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(player_path)
	stateMachine = anim_tree.get("parameters/playback")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector3.ZERO
	match stateMachine.get_current_node():
		"Run":
			# Navigation
			nav_agent.set_target_position(player.global_transform.origin)
			var next_nav_point = nav_agent.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
			# Change la dirrection du zombie
			look_at(Vector3(player.global_position.x + velocity.x, 
			player.global_position.y + velocity.y, player.global_position.z + velocity.z), Vector3.UP)
			# Condition
			anim_tree.set("parameters/conditions/attack", _target_in_range())
		"Attack":
			# Change la dirrection du zombie
			look_at(Vector3(player.global_position.x, player.global_position.y, player.global_position.z), Vector3.UP)
	
	
	
	anim_tree.set("parameters/conditions/run", !_target_in_range())
	
	anim_tree.get("parameters/playback")
	# End
	move_and_slide()
	
func _target_in_range():
	return global_position.distance_to(player.global_position) < attackRange
	
func hit_finished():
	
	if global_position.distance_to(player.global_position) < attackRange + 1.5:
		var dir = global_position.direction_to(player.global_position)
		player.hit(dir)
