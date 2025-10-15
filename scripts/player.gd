extends CharacterBody2D


const WALKING_SPEED = 300.0
const HIDDEN_SPEED = 50.0
var speed = WALKING_SPEED
const CLOTHING = {
	"no":{"name":"no","walk":"walking","walk_north":"walking_north","idle":"idle"},
	"halat":{"name":"halat","walk":"halated_walking","walk_north":"halated_north","idle":"halated_idle"}
}
var hid = false
var inv = []
var clothing = CLOTHING.no
var lives = 3

var peer_list = []

var user_id = -1

var collided

@onready var spr : AnimatedSprite2D = get_node("spr")
@onready var log : Label = get_node("gameGUI/lbl")
@onready var livesLog : Label = get_node("gameGUI/lives")
@onready var GUI : Control = get_node("inaGUI")
@onready var gameGUI : Control = get_node("gameGUI")

func _physics_process(delta):
	# Lives&Death
	if lives == 0:
		queue_free()
	livesLog.text = str(lives)
	
	# Movement
	var direction = Vector2.ZERO
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	if direction.x:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if direction.y:
		velocity.y = direction.y * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
		
	# Hide
	if Input.is_action_just_pressed("hide"):
		hid = !hid
		if hid:
			speed = HIDDEN_SPEED
		else:
			speed = WALKING_SPEED
		
	# Interaction
	if !GUI.visible:
		log.text = ""
		if collided != null:
			log.text = "["+InputMap.action_get_events("ina")[0].as_text()+"] to interact with "+collided.title
			if Input.is_action_just_pressed("ina"):
				collided.interact()
			if direction != Vector2.ZERO || Input.is_action_just_pressed("exina"):
				collided.exit()
		
		collided = null
		for index in get_slide_collision_count():
			if index >= 1:
				pass
			if get_slide_collision(index).get_collider() is InaObject && not get_slide_collision(index).get_collider() is Enemy:
				collided = get_slide_collision(index).get_collider()
				
	# Inventory
	if Input.is_action_just_pressed("inv"):
		if (GUI.get_node("title").text == "Inventory") && GUI.visible:
			GUI.visible = false
		else:
			GUI.visible = true
			GUI.get_node("title").text = "Inventory"
			GUI.get_node("button1").visible = false
			GUI.get_node("button2").visible = false
			GUI.get_node("text").text = "Clothing: " + clothing.name + "\nInventory: " + str(inv)
		
	
	# GUI Button Press
	if GUI.visible:
		if Input.is_action_just_pressed("b1p"):
			GUI._on_button_1_pressed()
		elif Input.is_action_just_pressed("b2p"):
			GUI._on_button_2_pressed()
		
	# Animations
	if !hid:
		if velocity != Vector2.ZERO:
			if velocity.y < 0:
				spr.play(clothing.walk_north)
			elif velocity.x != 0:
				spr.play(clothing.walk)
			else:
				spr.play(clothing.idle)
		else:
			spr.play(clothing.idle)
	else:
		spr.play("hidden")
		
	if velocity.x > 0:
		spr.flip_h = 1
	else:
		spr.flip_h = 0
	
	if user_id == Singleton.user_id:
		move_and_slide()
		rpc("_set_pos",global_transform.origin)
		rpc("_set_peers",peer_list)

func _ready() -> void:
	if user_id != Singleton.user_id:
		$cam.enabled = false
		$gameGUI.hide()
		$inaGUI.hide()
		
func addItem(item):
	inv.append(item)
	log.text = "+1 "+item

@rpc("any_peer") func _set_pos(ori):
	global_transform.origin = ori
	
@rpc("any_peer") func _set_peers(peers):
	peer_list = peers
