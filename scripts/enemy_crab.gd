extends CharacterBody2D

var starting_position_x

const SPEED = 100

func _ready():
	starting_position_x = self.global_position.x

func _physics_process(_delta):
	#print(self.global_position.x)
	#print(self.velocity.x)
	
	if self.global_position.x < starting_position_x:
		#print("in first if")
		self.velocity.x += 1 * SPEED
	
	if self.global_position.x > starting_position_x - 100:
		#print("in second if")
		self.velocity.x -= 1 * SPEED
	
	if self.velocity.x > 75:
		self.velocity.x = 75
	
	if self.velocity.x < -75:
		self.velocity.x = -75
	
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.name == "CaptainCat":
		print("Crab touch Captain Cat")
