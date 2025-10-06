extends CharacterBody2D
class_name Enemy

const SPEED = 300.0
const SIGHT = 40
const hurtDelay = 1.0
const pointDelay = 1.0

var seenPlayer = 0.0
var hurtTimeout = hurtDelay
var pointTimeout = pointDelay

@export var points : Array[Vector2] = [position + Vector2(0,-20), position + Vector2(-20,0), position + Vector2(0,20), position + Vector2(20,0)]
var i = 0

@onready var plr = get_node("../player")
@onready var spr : AnimatedSprite2D = get_node("spr")

func _ready():
	position = Vector2(0,10)

func canSee(obj):
	var q
	if obj is CharacterBody2D:
		q = PhysicsRayQueryParameters2D.create(global_position,obj.global_position)
		q.exclude = [self,obj]
	elif obj is Vector2:
		q = PhysicsRayQueryParameters2D.create(global_position,obj+global_position-position)
		q.exclude = [self]
	return get_world_2d().direct_space_state.intersect_ray(q).is_empty()
	
func canSeeHiddenPlayer():
	return canSee(plr)

func canSeePlayer():
	return canSeeHiddenPlayer() && (!plr.hid || (abs(plr.position - position).x < SIGHT && abs(plr.position - position).y < SIGHT))

func _physics_process(delta):
	# Player detection
	if canSeePlayer():
		seenPlayer += delta
	elif seenPlayer > 0:
		seenPlayer -= delta
	if seenPlayer > 1 && canSeeHiddenPlayer():
		velocity = position.direction_to(plr.position) * SPEED
	else:
		velocity = Vector2(move_toward(velocity.x,0,SPEED),move_toward(velocity.y,0,SPEED))
	
	# Idle movement
	if seenPlayer <= 0:
		if (abs(points[i] - position).x < 5 && abs(points[i] - position).y < 5):
			pointTimeout += delta
			if pointTimeout >= pointDelay:
				i += 1
				if i == points.size():
					i = 0
				pointTimeout = 0
		else:
			if canSee(points[i]):
				velocity = position.direction_to(points[i]) * SPEED / 2
			else:
				position = points[i]
	
	# Animations
	var anim
	if seenPlayer > 0:
		anim = "sus"
	if seenPlayer > 1 && canSeeHiddenPlayer():
		anim = "running"
	if seenPlayer <= 0:
		anim = "idle"
		if velocity != Vector2.ZERO:
			if velocity.y < 0:
				anim = "walking_north"
			elif velocity.x != 0:
				anim = "walking"
			else:
				anim = "idle"
	spr.play(anim)
	
	if velocity.x > 0:
		spr.flip_h = 1
	else:
		spr.flip_h = 0
		
	move_and_slide()
	
	# Colliding
	for index in get_slide_collision_count():
		if get_slide_collision(index).get_collider().name == "player" && hurtTimeout >= hurtDelay:
			plr.lives -= 1
			hurtTimeout = 0
	hurtTimeout += delta
