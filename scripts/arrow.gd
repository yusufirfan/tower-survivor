extends Area2D

var traveled_distance = 0
@export var damage = 25
@export var speed = 300

var tower
var reach

func _ready():
	tower = get_node("/root/Main/Tower")
	reach = tower.get_node("CollisionShape2D").shape.radius * 30

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	traveled_distance += 1000 * delta
	
	if traveled_distance > reach:
		queue_free()

func _on_body_entered(body):
	if body.has_method("take_damage"):
		queue_free()
		body.take_damage(damage)
