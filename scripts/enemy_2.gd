extends CharacterBody2D

@export var health = 250
@export var strength = 20
@export var speed = 70
@export var attack_range_x = 50
@export var attack_range_y = 65
@export var tolerance = 10
@export var prize = 10

var can_attack = true

var current_health = health
var tower
var enemy

func _ready():
	enemy = Enemy.new()
	tower = get_node("/root/Main/Tower")
	set_health_text()

func _process(delta):
	move_to_tower(delta)

func move_to_tower(delta):
	if tower:
		var direction = tower.position - position
		var distance_x = abs(direction.x)
		var distance_y = abs(direction.y)
		
		if distance_x > attack_range_x + tolerance or distance_y > attack_range_y + tolerance:
			$AnimatedSprite2D.play("run")
			velocity = direction.normalized() * speed
			move_and_slide()
			$AnimatedSprite2D.flip_h = direction.x < 0
		else:
			if can_attack:
				attack()
			
func take_damage(damage):
	current_health -= damage
	
	set_health_text()
	
	if current_health <= 0:
		get_parent().get_parent().get_node("Tower").pop_list()
		enemy.add_gold(prize)
		queue_free()
		
func set_health_text():
	$ProgressBar.max_value = health	
	$ProgressBar.value = current_health
	$ProgressBar/Label.text = str(current_health) + "/" + str(health)

func attack():
		$AnimatedSprite2D.play("attack")
		tower.check_health(strength)
		
		can_attack = false
		$Timer.start()

func _on_timer_timeout():
	can_attack = true
