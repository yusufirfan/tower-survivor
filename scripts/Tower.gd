class_name Tower
extends StaticBody2D

var state = State.new()
var health = state.tower_health

var weapon_string
var weapon

var target_list: Array = []
var target: CharacterBody2D = null

var can_shoot = true
var isdone = false
var enemy_count
var dead_enemy = 0

signal healthChanged

func _draw():
	var collision_shape = $Area2D/CollisionShape2D
	var radius = collision_shape.shape.radius
	var position = collision_shape.position
	var scale_y = 0.7
	var dot_spacing = 10.0  # Noktalar arasındaki mesafe
	var dot_radius = 2.0   # Noktaların yarıçapı

	# Çemberin etrafında nokta çizgisi için noktaları hesapla
	var points = []
	var segments = int(2 * PI * radius / dot_spacing)  # Noktaların sayısını hesapla

	for i in range(segments):
		var angle = i * (2 * PI / segments)
		var x = cos(angle) * radius
		var y = sin(angle) * radius * scale_y
		var dot_position = position + Vector2(x, y)
		points.append(dot_position)

	# Noktaları çiz
	for dot in points:
		draw_circle(dot, dot_radius, Color(1, 1, 1, 1))

func _process(delta):
	weapon_string = GlobalState.weapons[GlobalState.current_weapon]['path']
	weapon = load(weapon_string)
	if target_list and can_shoot:
		shoot()

func check_health(strength):
	health -= strength
	healthChanged.emit()
	if health <= 0:
		queue_free()

#Shoot function
func shoot():
	if len(target_list) > 0:
		var target = target_list[0]
		if is_instance_valid(target):
			var new_weapon = weapon.instantiate() 
			var direction = target.position - position
			new_weapon.look_at(direction)
			add_child(new_weapon)
			can_shoot = false
			$Timer.start()
		else:
			pop_list()
#Shoot function's timer
func _on_timer_timeout():
	can_shoot = true

#For finding targets and listing them
#!!!Dead Function!!!
func find_target():
	var spawner = get_parent().get_node("Spawner")
	if spawner:
		for body in spawner.get_children():
			if body is CharacterBody2D and body.name.begins_with("enemy") and not body in target_list:
				target_list.append(body)

#When enemies is inside of Area2d, it lists them with find target function
func _on_area_2d_body_entered(body):
	if body is Enemy:
		target_list.append(body)
	
#When an enemy die this function erase it from target_list array
func pop_list():
	if len(target_list) > 0:
		dead_enemy += 1
		target_list.remove_at(0)

	# Check if all enemies are dead to start a new wave
	if dead_enemy >= enemy_count:
		isdone = true
		dead_enemy = 0
		# Call new_wave function from the Spawner node
		await get_tree().create_timer(0.5).timeout
		get_parent().get_node("Spawner").new_wave()

#Gets enemy_count data from Spawner.gd
func send_enemy_count(dd):
	enemy_count = dd
