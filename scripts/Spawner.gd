extends Node2D

var enemy_scene
var enemy_count = 0
var current_wave_data
var current_enemy_count = 0
var wave_data

var state

signal wave_changed

func _ready():
	state = State.new()
	start_wave()

func start_wave():
	if "wave_%d" % GlobalState.current_wave in state.waves:
		current_wave_data = state.waves["wave_%d" % GlobalState.current_wave]
		enemy_scene = load(current_wave_data["enemy"])
		current_enemy_count = current_wave_data["count"]
		enemy_count = 0
	else:
		GlobalState.game_beat()
	
func _on_timer_timeout():
	wave_data = GlobalState.current_wave
	if enemy_count < current_enemy_count:
		get_parent().get_node("Tower").send_enemy_count(current_enemy_count)
		var enemy = enemy_scene.instantiate()
		
		var random_index = randi() % state.spawn_points.size()
		enemy.position = state.spawn_points[random_index]

		enemy.name = "enemy_%d" % enemy_count
		enemy_count += 1

		add_child(enemy)

func new_wave():
	GlobalState.add_gold(current_wave_data["waveendgold"])
	GlobalState.current_wave += 1
	GlobalState.wave_changed.emit()
	start_wave()
