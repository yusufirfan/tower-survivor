class_name State extends Node2D

signal gold_changed

var tower
var tower_health = 1000
var gold = 0
var extra_reach = 0

func _ready():
	tower = get_node("/root/Main/Tower")

func add_gold(amount):
	gold += amount
	gold_changed.emit()

var weapons = {
	"arrow":{
		"damage": 20,
		"speed": 300,
		"reach": 1500 + extra_reach
	},
	"rock":{
		"damage": 40,
		"speed": 220,
		"reach": 1700 + extra_reach
	}
}

var waves = {
	"wave_1": {
		"enemy": "res://scenes/enemy_1.tscn",
		"count": 3,
		"waveendgold": 50
	},
	"wave_2": {
		"enemy": "res://scenes/enemy_1.tscn",
		"count": 5,
		"waveendgold": 75
	},
	"wave_3": {
		"enemy": "res://scenes/enemy_1.tscn",
		"count": 10,
		"waveendgold": 100
	},
	"wave_4": {
		"enemy": "res://scenes/enemy_2.tscn",
		"count": 2,
		"waveendgold": 85
	},
	"wave_5": {
		"enemy": "res://scenes/enemy_2.tscn",
		"count": 5,
		"waveendgold": 150
	},
	"wave_6": {
		"enemy": "res://scenes/enemy_2.tscn",
		"count": 7,
		"waveendgold": 225
	},
	"wave_7": {
		"enemy": "res://scenes/boss_1.tscn",
		"count": 1,
		"waveendgold": 350
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
		"attack_range_x": 50,
		"attack_range_y": 65,
		"tolerance": 10,
		"prize": 5
	},
	"enemy_2": {
		"name": "enemy_2",
		"scene": "res://scenes/enemy_2.tscn",
		"health": 250,
		"strength": 20,
		"speed": 40,
		"attack_range_x": 50,
		"attack_range_y": 65,
		"tolerance": 10,
		"prize": 10
	},
	"boss_1": {
		"name": "boss_1",
		"scene": "res://scenes/boss_1.tscn",
		"health": 1000,
		"strength": 50,
		"speed": 50,
		"attack_range_x": 50,
		"attack_range_y": 65,
		"tolerance": 10,
		"prize": 10
	},
}
