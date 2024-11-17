extends CharacterBody2D

@onready var player_camera = $Camera2D
@onready var player_sprite = $Sprite2D

var pirate_ship_textures = [
	preload("res://assets/sprites/pirate_ship_2.png"),
	preload("res://assets/sprites/pirate_ship_2_down.png")
]
var collision_count = 0

const SPEED = 100.0

func _ready():
	player_camera.limit_left = 0
	player_camera.limit_right = 2525
	player_camera.limit_top = 0
	player_camera.limit_bottom = 671

func _physics_process(delta):
	handle_ship_movement()
	move_and_slide()
	
	#This is sort of an inconsistent way to check collision, probably should use an Area2d or someshit idk
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("islands"):  # Optional: Check if it's part of a specific group
			collision_count += 1
			print("hitting island ", collision_count)

func handle_ship_movement():
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_ship_down"):
		player_sprite.texture = pirate_ship_textures[1]
		player_sprite.flip_v = false
		velocity.y += 1 * SPEED
	
	if Input.is_action_pressed("move_ship_up"):
		player_sprite.texture = pirate_ship_textures[1]
		player_sprite.flip_v = true
		velocity.y += -1 * SPEED
	
	if Input.is_action_pressed("move_ship_left"):
		player_sprite.texture = pirate_ship_textures[0]
		player_sprite.flip_h = false
		player_sprite.flip_v = false #with left and right case its just good to have the ship not be flipped vertically or it looks weird as hell
		velocity.x -= 1 * SPEED
	
	if Input.is_action_pressed("move_ship_right"):
		player_sprite.texture = pirate_ship_textures[0]
		player_sprite.flip_h = true
		player_sprite.flip_v = false #with left and right case its just good to have the ship not be flipped vertically or it looks weird as hell
		velocity.x += 1 * SPEED
	
	#speed caps to 100 in every direction
	if velocity.x > 100:
		velocity.x = 100
	
	if velocity.x < -100:
		velocity.x = -100
	
	if velocity.y > 100:
		velocity.y = 100
	
	if velocity.y < -100:
		velocity.y = -100

func ship_hits_island():
	pass
