extends TextureProgressBar

@export var tower: Tower

func _ready():
	tower.healthChanged.connect(update)
	max_value = tower.health
	value = tower.health

func update():
	value = tower.health
