extends CharacterBody2D

@onready var player_camera = $Camera2D
@onready var player_sprite = $Sprite2D

@onready var dock_message = preload("res://scenes/dock_ship_message.tscn")
var dock_message_instance

#array to hold ship textures
var pirate_ship_textures = [
	preload("res://assets/sprites/pirate_ship_2.png"),
	preload("res://assets/sprites/pirate_ship_2_down.png")
]
var is_active = true #var to decide whether or not the ship can move
var island_touched_name

const SAIL_SPEED = 75.0

func _ready():
	#set camera limit so it doesnt see the out of bounds
	self.global_position = Global.last_known_ship_position
	player_camera.limit_left = 0
	player_camera.limit_right = 2525
	player_camera.limit_top = 0
	player_camera.limit_bottom = 671

func _physics_process(delta):
	if is_active:
		handle_ship_movement()
		move_and_slide()
	else:
		decide_to_dock()

func handle_ship_movement():
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_ship_down"):
		player_sprite.texture = pirate_ship_textures[1]
		player_sprite.flip_v = false
		velocity.y += 1 * SAIL_SPEED
	
	if Input.is_action_pressed("move_ship_up"):
		player_sprite.texture = pirate_ship_textures[1]
		player_sprite.flip_v = true
		velocity.y += -1 * SAIL_SPEED
	
	if Input.is_action_pressed("move_ship_left"):
		player_sprite.texture = pirate_ship_textures[0]
		player_sprite.flip_h = false
		player_sprite.flip_v = false #with left and right case its just good to have the ship not be flipped vertically or it looks weird as hell
		velocity.x -= 1 * SAIL_SPEED
	
	if Input.is_action_pressed("move_ship_right"):
		player_sprite.texture = pirate_ship_textures[0]
		player_sprite.flip_h = true
		player_sprite.flip_v = false #with left and right case its just good to have the ship not be flipped vertically or it looks weird as hell
		velocity.x += 1 * SAIL_SPEED
	
	#speed caps to 100 in every direction
	if velocity.x > 100:
		velocity.x = 100
	
	if velocity.x < -100:
		velocity.x = -100
	
	if velocity.y > 100:
		velocity.y = 100
	
	if velocity.y < -100:
		velocity.y = -100

#function that pauses movement of PirateShip and instantiates DockShipMessage scene
func dock_ship(island_name):
	is_active = false
	dock_message_instance = dock_message.instantiate()
	self.add_child(dock_message_instance)
	dock_message_instance.global_position.y += 50
	
	island_touched_name = island_name

func go_to_level():
	print(island_touched_name)
	
	match island_touched_name:
		"BasicIsland":
			get_tree().change_scene_to_file("res://scenes/basic_island_level_1.tscn")
			Global.last_known_ship_position.x = self.global_position.x
			Global.last_known_ship_position.y = self.global_position.y + 50

#function that asks checks for player input Y/N on whether or not to dock ship and enter level
func decide_to_dock():
	#TODO: need to add some sort of way to figure out what scene to enter in, not really sure how Im going to go about this. 
	#Either way, should probably limit island amount to something tiny for now. Maybe 6?
	if Input.is_action_just_pressed("yes_option"):
		print("WE ENTERING DA LEVEL")
		go_to_level()
	
	if Input.is_action_just_pressed("no_action"):
		print("made it in the no")
		dock_message_instance.queue_free()
		is_active = true
