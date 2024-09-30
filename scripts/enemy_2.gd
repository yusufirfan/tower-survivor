extends Enemy

var NAME = "enemy_2"

var health = GlobalState.enemies[NAME]['health']
var strength = GlobalState.enemies[NAME]['strength']
var speed = GlobalState.enemies[NAME]['speed']
var attack_range_x = GlobalState.enemies[NAME]['attack_range_x']
var attack_range_y = GlobalState.enemies[NAME]['attack_range_y']
var tolerance = GlobalState.enemies[NAME]['tolerance']
var prize = GlobalState.enemies[NAME]['prize']

var can_attack = true

var current_health = health
var tower = GlobalState.tower
var enemy

var unique_id

func _ready():
	unique_id = randi() % 1000
	enemy = Enemy.new()
	set_health_text()

func _process(delta):
	if current_health > 0:
		move_to_tower(delta)

func move_to_tower(delta):
	if tower:
		var direction = tower.position - position
		var distance_x = abs(direction.x)
		var distance_y = abs(direction.y)
		
		if distance_x > attack_range_x + tolerance or distance_y > attack_range_y + tolerance:
			$AnimationPlayer.play("run")
			velocity = direction.normalized() * speed
			move_and_slide()
			$Sprite2D.flip_h = direction.x < 0
		else:
			if can_attack:
				attack()
			
func take_damage(damage):
	if ($CollisionShape2D.is_disabled() == false):
		current_health -= damage
		set_health_text()
		print(current_health)
		
		if current_health <= 0:
			$AnimationPlayer.pause()
			$AnimationPlayer.play("death")
			tower.pop_list()
			$CollisionShape2D.disabled = true
			await $AnimationPlayer.animation_finished
			
			enemy.add_gold(prize)
			queue_free()
		
func set_health_text():
	$ProgressBar.max_value = health	
	$ProgressBar.value = current_health
	$ProgressBar/Label.text = str(current_health) + "/" + str(health)

func attack():
		$AnimationPlayer.play("attack")
		tower.check_health(strength)
		
		can_attack = false
		$Timer.start()

func _on_timer_timeout():
	can_attack = true
