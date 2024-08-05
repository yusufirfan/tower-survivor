extends CanvasLayer

@export var tower: Tower
@onready var tower_health_bar = $TowerHealthBar
@onready var gold_label = $Control/GoldLabel
@onready var gold_multiplier = $Control/GoldMultLabel
@onready var wave_counter = $WaveCounter

func _ready():
	tower.healthChanged.connect(update_tower_health)
	GlobalState.gold_changed.connect(update_gold_label)
	GlobalState.gold_multiplier_changed.connect(update_gold_multiplier)
	tower.wave_changed.connect(write_wave)
	tower_health_bar.max_value = tower.health
	tower_health_bar.value = tower.health
	gold_label.text = "[img]res://assets/ui/coin.png[/img]" + str(GlobalState.gold)
	wave_counter.text = "Wave: " + str(Spawner.current_wave) + "/" + str(len(GlobalState.waves))

func update_tower_health():
	tower_health_bar.value = tower.health

func update_gold_label():
	var number = GlobalState.gold
	var rounded_number = round(number)
	gold_label.text = "[img]res://assets/ui/coin.png[/img]" + str(rounded_number)
	
func update_gold_multiplier():
	gold_multiplier.text = " Current Multiplier: " + str(GlobalState.gold_multiplier) + "x"

func write_wave():
	wave_counter.text = "Wave: " + str(Spawner.current_wave) + "/" + str(len(GlobalState.waves))
