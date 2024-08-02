class_name State extends Node2D

signal gold_changed

var tower_health = 1000
var gold = 0

func add_gold(amount):
	gold += amount
	gold_changed.emit()

var waves = {
	"wave_1": {
		"enemy": "res://scenes/enemy_1.tscn",
		"count": 3,
		"waveendgold": 100
	},
	"wave_2": {
		"enemy": "res://scenes/enemy_1.tscn",
		"count": 5,
		"waveendgold": 150
	},
	"wave_3": {
		"enemy": "res://scenes/enemy_2.tscn",
		"count": 3,
		"waveendgold": 200
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

var enemies = {
	"enemy_1": {
		"scene": "res://scenes/enemy_1.tscn",
		"health": 100,
		"strength": 10,
		"speed": 50,
		"attack_range_x": 10,
		"attack_range_y": 10,
		"tolerance": 10,
		"prize": 5
	},
	"enemy_2": {
		"scene": "res://scenes/enemy_2.tscn",
		"health": 250,
		"strength": 20,
		"speed": 40,
		"attack_range_x": 50,
		"attack_range_y": 65,
		"tolerance": 10,
		"prize": 10
	},
}
