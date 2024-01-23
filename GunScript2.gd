extends Node


@export var gunDépart: PackedScene
var positionDuGun
var equippedWeapon : Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	positionDuGun = get_parent().find_child("PositionDuGun")
	if gunDépart:
		equip_weapon(gunDépart)

func equip_weapon(Prendre_arme):
	if equippedWeapon:
		equippedWeapon.queue_free()
	else:
		equippedWeapon = Prendre_arme.instantiate()
		positionDuGun.add_child(equippedWeapon)
