extends Area2D

var NAME = "arrow"

var DAMAGE = GlobalState.weapons[NAME]['damage']
var SPEED = GlobalState.weapons[NAME]['speed']
var REACH = GlobalState.weapons[NAME]['reach']
var traveled_distance = 0

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	traveled_distance += 1000 * delta
	
	if traveled_distance > REACH:
		queue_free()

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(DAMAGE)
		queue_free()
