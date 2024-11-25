extends CharacterBody2D

@onready var captain_cat_sprite = $AnimatedSprite2D
@onready var captain_cat_camera = $Camera2D

const SPEED = 100
const GRAVITY = 400
const JUMP_FORCE = 225

var is_active = true

func _ready():
	#set camera limit so it doesnt see the out of bounds
	captain_cat_camera.limit_left = 0
	captain_cat_camera.limit_right = 2525
	captain_cat_camera.limit_top = 0
	captain_cat_camera.limit_bottom = 671

func _physics_process(delta):
	handle_animation()
	
	if is_active:
		handle_movement(delta)
		move_and_slide()

func handle_movement(delta):
	print(self.velocity.y)
	if is_on_floor() == false:
		self.velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("cat_jump") && is_on_floor() == true:
		self.velocity.y = -JUMP_FORCE
	
	self.velocity.x = 0
	
	if Input.is_action_pressed("move_cat_left"):
		captain_cat_sprite.flip_h = true
		self.velocity.x -= 1 * SPEED
	
	if Input.is_action_pressed("move_cat_right"):
		captain_cat_sprite.flip_h = false
		self.velocity.x += 1 * SPEED
	
	if self.velocity.x > 100:
		self.velocity.x = 100
	
	if self.velocity.x < -100:
		self.velocity.x = -100

func handle_animation():
	if self.velocity.y < 0:
		captain_cat_sprite.play("jump")
	
	if self.velocity.y > 0:
		captain_cat_sprite.play("falling")
	
	if self.velocity.x == 0 && is_on_floor():
		captain_cat_sprite.play("idle")
	
	if self.velocity.x > 0 || self.velocity.x < 0:
		if is_on_floor():
			captain_cat_sprite.play("running")
