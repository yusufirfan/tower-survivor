class_name State extends Resource

var waves = {
	"wave_1": {
		"enemy": "res://scenes/enemy_1.tscn",
		"count": 1,
		"waveendgold": 100
	},
	"wave_2": {
		"enemy": "res://scenes/enemy_2.tscn",
		"count": 3,
		"waveendgold": 150
	},
	"wave_3": {
		"enemy": "res://scenes/enemy_1.tscn",
		"count": 3,
		"waveendgold": 150
	},
	"wave_4": {
		"enemy": "res://scenes/boss_1.tscn",
		"count": 1,
		"waveendgold": 300
	}
}

var spawn_points = [
	Vector2(1280, 350),  # Sağ orta
	Vector2(0, 350),     # Sol orta
	Vector2(640, 0),     # Üst orta
	Vector2(640, 720)    # Alt orta
]
