extends RichTextLabel

func _ready():
	GlobalState.gold_changed.connect(update)

func update():
	text = "[img]res://assets/ui/coin.png[/img]" + str(GlobalState.gold)
