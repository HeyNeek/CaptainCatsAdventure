extends CharacterBody2D

const SPEED = 100

func _physics_process(delta):
	handle_movement()
	move_and_slide()

func handle_movement():
	self.velocity.x = 0
	
	if Input.is_action_pressed("move_cat_left"):
		self.velocity.x -= 1 * SPEED
	
	if Input.is_action_pressed("move_cat_right"):
		self.velocity.x += 1 * SPEED
	
	if self.velocity.x > 100:
		self.velocity.x = 100
	
	if self.velocity.x < -100:
		self.velocity.x = -100
