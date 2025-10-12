extends InaObject
class_name NPC

@export var SPEED = 300.0
@export var pointDelay = 1.0
var pointTimeout = pointDelay

@onready var spr : AnimatedSprite2D = get_node("spr")

@export var points : Array[Vector2]
var i = 0

func canSee(obj):
	var q
	if obj is CharacterBody2D:
		q = PhysicsRayQueryParameters2D.create(global_position,obj.global_position)
		q.exclude = [self,obj]
	elif obj is Vector2:
		q = PhysicsRayQueryParameters2D.create(global_position,obj+global_position-position)
		q.exclude = [self]
	return get_world_2d().direct_space_state.intersect_ray(q).is_empty()

func move(delta):
	if points == []:
		return
	if (abs(points[i] - position).x < 1 && abs(points[i] - position).y < 1):
		pointTimeout += delta
		velocity = Vector2.ZERO
		position = points[i]
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

func _physics_process(delta):
	move(delta)
	relocate()

func relocate():
	if Singleton.user_id == 0:
		move_and_slide()
		rpc("_set_pos",global_transform.origin)

@rpc("any_peer") func _set_pos(ori):
	global_transform.origin = ori
	
