extends CharacterBody2D

var goal
var alive = 0.0

func _ready() -> void:
	for c in $"/root/game".get_children():
		if c is Enemy:
			if goal == null or abs(goal.position - position) > abs(c.position - position):
				goal = c.position
	
	if goal != null: 
		if goal.y > position.y:
			position.y += 30
	else:
		queue_free()

func _physics_process(delta: float) -> void:
	alive += delta
	if alive >= 1.0:
		queue_free()
		
	position += position.direction_to(goal)
	
	move_and_slide()
	
	for index in get_slide_collision_count():
		if get_slide_collision(index).get_collider() is InaObject:
			get_slide_collision(index).get_collider().delete()
			queue_free()
