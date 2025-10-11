extends NPC
class_name Enemy

var SIGHT = 40
var hurtDelay = 1.0

var seenPlayer = 0.0
var hurtTimeout = hurtDelay

func _ready():
	points = [position + Vector2(0,-20), position + Vector2(-20,0), position + Vector2(0,20), position + Vector2(20,0)]
	
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
		move(delta)
	
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
