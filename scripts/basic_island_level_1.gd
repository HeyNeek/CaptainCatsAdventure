extends Node2D

@onready var board_ship_message_scene = preload("res://scenes/board_ship_message.tscn")

@onready var captain_cat = $CaptainCat
@onready var tree_3 = $TreeSprite3

var board_ship_message_instance
var should_decide_to_leave = false

func _process(_delta):
	if should_decide_to_leave:
		if Input.is_action_just_pressed("yes_option"):
			get_tree().change_scene_to_file("res://scenes/ocean_map.tscn")
		
		if Input.is_action_just_pressed("no_action"):
			should_decide_to_leave = false
			captain_cat.is_active = true
			board_ship_message_instance.queue_free()

func _ready():
	tree_3.flip_h = true

func _on_exit_area_body_entered(body):
	if body.name == "CaptainCat":
		print("Hi captain cat! :3")
		body.is_active = false
		body.captain_cat_sprite.play("idle")
		should_decide_to_leave = true
		
		board_ship_message_instance = board_ship_message_scene.instantiate()
		body.add_child(board_ship_message_instance)
		board_ship_message_instance.global_position.x += 50
		board_ship_message_instance.global_position.y += 25
