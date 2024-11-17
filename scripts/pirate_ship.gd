extends CharacterBody2D

@onready var player_camera = $Camera2D
@onready var player_sprite = $Sprite2D

const SPEED = 100.0

func _ready():
	player_camera.limit_left = 0
	player_camera.limit_right = 2525
	player_camera.limit_top = 0
	player_camera.limit_bottom = 671

func _physics_process(delta):
	handle_ship_movement()
	move_and_slide()

func handle_ship_movement():
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_ship_down"):
		velocity.y += 1 * SPEED
	
	if Input.is_action_pressed("move_ship_up"):
		velocity.y += -1 * SPEED
	
	if Input.is_action_pressed("move_ship_left"):
		player_sprite.flip_h = false
		velocity.x -= 1 * SPEED
	
	if Input.is_action_pressed("move_ship_right"):
		player_sprite.flip_h = true
		velocity.x += 1 * SPEED
	
	if velocity.x > 100:
		velocity.x = 100
	
	if velocity.x < -100:
		velocity.x = -100
	
	if velocity.y > 100:
		velocity.y = 100
	
	if velocity.y < -100:
		velocity.y = -100
