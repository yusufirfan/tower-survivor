extends Node2D

var enemy_scene
var enemy_count = 0
var current_wave = 4
var current_wave_data
var current_enemy_count = 0

const State = preload("res://State.gd")  # State.gd dosyasını preload ediyoruz
var state

func _ready():
	state = State.new()  # State sınıfının yeni bir örneğini oluşturuyoruz
	start_wave()

func start_wave():
	# Geçerli dalga olup olmadığını kontrol edin
	if "wave_%d" % current_wave in state.waves:
		current_wave_data = state.waves["wave_%d" % current_wave]
		enemy_scene = load(current_wave_data["enemy"])
		current_enemy_count = current_wave_data["count"]
		enemy_count = 0
		print(current_wave)
	else:
		print("No more waves available!")
	
func _on_timer_timeout():
	if enemy_count < current_enemy_count:
		get_parent().get_node("Tower").send_enemy_count(current_enemy_count)
		get_parent().get_node("Tower").send_current_wave(current_wave)
		var enemy = enemy_scene.instantiate()
		
		var random_index = randi() % state.spawn_points.size()
		enemy.position = state.spawn_points[random_index]

		# Benzersiz bir isim atayın
		enemy.name = "enemy_%d" % enemy_count
		enemy_count += 1

		add_child(enemy)

func new_wave():
	current_wave += 1
	start_wave()
