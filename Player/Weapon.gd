extends Node2D

var bulletSpeed = 500
var Bullet = preload("res://Player/BulletNode.tscn")

func _physics_process(delta):
	look_at(get_global_mouse_position())
	flipSprites()
	if Input.is_action_just_pressed("attack"):
		shoot()

func shoot():
	var bullet = Bullet.instance()
	owner.add_child(bullet)
	bullet.transform = $Muzzle.global_transform

func flipSprites():
	var direction = sign(get_global_mouse_position().x - global_position.x)
	if direction < 0:
		$Sprite.flip_h = true
		$Sprite.rotation_degrees = 180
		$Muzzle.position.y = -$Muzzle.position.y
	else:
		$Sprite.flip_h = false
		$Sprite.rotation_degrees = 360
		$Muzzle.position.y = $Muzzle.position.y
