class_name State extends Node2D

#Signals
signal gold_changed
signal gold_multiplier_changed
signal wave_changed

#Common Variables
var tower
var tower_health = 1000
var gold = 100
var current_wave = 1

#Upgrade Variables
var gold_multiplier = 1
var base_damage = 0
var speed_multiplier = 1
var reach = 1200
var current_weapon
var second_weapon

#Ready Function
func _ready():
	tower = get_node("/root/Main/Tower")
	add_to_lists()
	current_weapon = weapon_list[0]
	next_weapon_image()

### Upgrade Functions ###
#Gold Multiplier Function
func increase_gold_multiplier(percentage: float):
	gold_multiplier += (percentage / 100)
	gold_multiplier_changed.emit()
#Base Damage Function
func increase_base_damage(damage: float):
	base_damage += damage
	update_weapon_data()
#Speed Multiplier Function
func increase_speed_multiplier():
	tower.get_node("Timer").wait_time -= 0.05
	update_weapon_data()
func increase_reach_multiplier():
	tower.get_node("Area2D").get_node("CollisionShape2D").shape.radius += 10
	tower.queue_redraw()
	print(tower.get_node("Area2D").get_node("CollisionShape2D").shape.radius)
	update_weapon_data()

func update_weapon_data():
	for weapon in weapon_list:
		weapons[weapon]["damage"] = damage_list[weapon] + base_damage
		weapons[weapon]["speed"] = speed_list[weapon] * speed_multiplier

### Gold Functions ###
#Gold Add and Remove Functions
func add_gold(amount):
	gold += amount * gold_multiplier
	gold_changed.emit()
func remove_gold(amount):
	gold -= amount
	gold_changed.emit()
func check_gold(amount):
	if gold>=amount:
		return true
	return false
	

func increase_reach(amount: float):
	reach += amount

func game_beat():
	var panel = get_node("/root/Main/GUI/Panel")
	var label = get_node("/root/Main/GUI/Panel/Label")
	var duration = 0.5
	var step = 0.05
	
	panel.show()
	for i in range(0, int(duration/step)):
		var t = i * step / duration
		var ease_value = t * t * (3.0 - 2.0 * t)  # Ease-in-out hesaplaması
		panel.modulate.a = ease_value
		await get_tree().create_timer(step).timeout
	
	await get_tree().create_timer(0.5).timeout
	
	label.show()
	for i in range(0, int(duration/step)):
		var t = i * step / duration
		var ease_value = t * t * (3.0 - 2.0 * t)  # Ease-in-out hesaplaması
		label.modulate.a = ease_value
		await get_tree().create_timer(step).timeout


### Weapons and Functions ###
var weapons = {
	"arrow": {
		"path": "res://scenes/arrow.tscn",
		"damage": 25,
		"speed": 300,
	},
	"rock": {
		"path": "res://scenes/rock.tscn",
		"damage": 50,
		"speed": 300,
	}
}
#List Weapons
var weapon_list = []
var damage_list = {}
var speed_list = {}
#Set weapon_list array
func add_to_lists():
	for weapon_name in weapons.keys():
		weapon_list.append(weapon_name)
		damage_list[weapon_name] = weapons[weapon_name]['damage']
		speed_list[weapon_name] = weapons[weapon_name]['speed']

#Next weapon
func next_weapon_image():
	var current_index = weapon_list.find(current_weapon)
	current_index += 1
	if current_index >= weapon_list.size():
		current_index = 0
	second_weapon = weapon_list[current_index]
func next_weapon():
	var current_index = weapon_list.find(current_weapon)
	current_index += 1
	if current_index >= weapon_list.size():
		current_index = 0
	current_weapon = weapon_list[current_index]
	next_weapon_image()
#Base Damage Increase Function

#Waves
var waves = {
	"wave_1": {
		"enemy": "res://scenes/enemy_1.tscn",
		"count": 1,
		"waveendgold": 75
	},
	"wave_2": {
		"enemy": "res://scenes/enemy_1.tscn",
		"count": 3,
		"waveendgold": 125
	},
	"wave_3": {
		"enemy": "res://scenes/enemy_1.tscn",
		"count": 5,
		"waveendgold": 200
	},
	"wave_4": {
		"enemy": "res://scenes/enemy_1.tscn",
		"count": 7,
		"waveendgold": 300
	},
	"wave_5": {
		"enemy": "res://scenes/enemy_2.tscn",
		"count": 1,
		"waveendgold": 300
	},
	"wave_6": {
		"enemy": "res://scenes/enemy_2.tscn",
		"count": 3,
		"waveendgold": 450
	},
	"wave_7": {
		"enemy": "res://scenes/enemy_2.tscn",
		"count": 5,
		"waveendgold": 650
	},
	"wave_8": {
		"enemy": "res://scenes/enemy_2.tscn",
		"count": 7,
		"waveendgold": 750
	},
	"wave_9": {
		"enemy": "res://scenes/enemy_2.tscn",
		"count": 10,
		"waveendgold": 1000
	},
	"wave_10": {
		"enemy": "res://scenes/boss_1.tscn",
		"count": 1,
		"waveendgold": 1250
	}
}

#Spawn Points
var spawn_points = [
	Vector2(1280, 350),  # Sağ orta
	Vector2(0, 350),     # Sol orta
	Vector2(640, 0),     # Üst orta
	Vector2(640, 720)    # Alt orta
]

#Enemies
var enemies = {
	"enemy_1": {
		"scene": "res://scenes/enemy_1.tscn",
		"health": 100,
		"strength": 10,
		"speed": 50,
		"attack_range_x": 50,
		"attack_range_y": 65,
		"tolerance": 10,
		"prize": 10
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
		"prize": 25
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
		"prize": 500
	},
}
