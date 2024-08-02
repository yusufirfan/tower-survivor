class_name Tower
extends StaticBody2D

var state = State.new()
var health = state.tower_health

var arrow = preload("res://scenes/arrow.tscn")

var target_list: Array = []
var target: CharacterBody2D = null

var can_shoot = true
var isdone = false
var enemy_count
var current_wave
var dead_enemy = 0

signal healthChanged

func _process(delta):
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
			var new_arrow = arrow.instantiate() 
			var direction = target.position - position
			new_arrow.look_at(direction)
			add_child(new_arrow)
			can_shoot = false
			$Timer.start()
		else:
			pop_list()
#Shoot function's timer
func _on_timer_timeout():
	can_shoot = true

#For finding targets and listing them
func find_target():
	var spawner = get_parent().get_node("Spawner")
	if spawner:
		for body in spawner.get_children():
			if body is CharacterBody2D and body.name.begins_with("enemy") and not body in target_list:
				target_list.append(body)

#When enemies is inside of Area2d, it lists them with find target function
func _on_area_2d_body_entered(body):
	find_target()
	
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

#Gets current_wave from Spawner.gd
func send_current_wave(dd):
	current_wave = dd

func _on_timer_2_timeout():
	pass # Replace with function body.
