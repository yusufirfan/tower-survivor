extends Control

@onready var button1 = $VBoxContainer/HBoxContainer1/Button
@onready var button2 = $VBoxContainer/HBoxContainer1/Button2
@onready var button3 = $VBoxContainer/HBoxContainer1/Button3
@onready var button4 = $VBoxContainer/HBoxContainer1/Button4
@onready var button5 = $VBoxContainer/HBoxContainer1/Button5

@onready var infotitle = $InfoContainer/InfoTitle
@onready var infodesc = $InfoContainer/InfoDesc
@onready var infocost = $InfoContainer/InfoCost
@onready var infofirst = $InfoContainer/InfoFirst
@onready var infosecond = $InfoContainer/InfoSecond

var button1_press_count = 0
var button2_press_count = 0
var button3_press_count = 0
var button4_press_count = 0
var button5_press_count = 0

func _ready():
	button1.pressed.connect(_on_Button1_pressed)
	button2.pressed.connect(_on_Button2_pressed)
	button3.pressed.connect(_on_Button3_pressed)
	button4.pressed.connect(_on_Button4_pressed)
	button5.pressed.connect(_on_Button5_pressed)
	var texture = load("res://assets/projectiles/"+GlobalState.second_weapon+".png")
	button5.get_node("TextureRect").texture = texture

func reset_other_counters(except):
	if except != 1:
		button1_press_count = 0
	if except != 2:
		button2_press_count = 0
	if except != 3:
		button3_press_count = 0
	if except != 4:
		button4_press_count = 0
	if except != 5:
		button5_press_count = 0

func make_cost(amount):
	return "[img]res://assets/ui/coin.png[/img] COST: %d GOLD" % amount

#Gold Multiplier Button
func _on_Button1_pressed():
	button1_press_count += 1
	reset_other_counters(1)
	if button1_press_count == 1:
		infotitle.text = "[img]res://assets/ui/upgrades/gold_multiplier.png[/img] Gold Multiplier"
		infofirst.text = "+0.1x Gold"
		infosecond.text = ""
		infodesc.text = "Increase your gold multiplier. It affects what you gain after killing enemies and finishing waves."
		infocost.text = make_cost(25)
	elif button1_press_count == 2:
		if GlobalState.check_gold(25):
			GlobalState.increase_gold_multiplier(5)
			GlobalState.remove_gold(25)
		button1_press_count = 1

#Base Damage Button
func _on_Button2_pressed():
	button2_press_count += 1
	reset_other_counters(2)
	if button2_press_count == 1:
		infotitle.text = "[img]res://assets/ui/upgrades/base_damage.png[/img] Base Damage"
		infofirst.text = "+5 Base DMG"
		infodesc.text = "Increase your base damage. It affects how much damage you deal to enemies."
		infocost.text = make_cost(50)
	elif button2_press_count == 2:
		if GlobalState.check_gold(50):
			GlobalState.increase_base_damage(5)
			GlobalState.remove_gold(50)
		button2_press_count = 1
	infosecond.text = "Cur: " + str(GlobalState.base_damage)

#Quicker Attacks Button
func _on_Button3_pressed():
	button3_press_count += 1
	reset_other_counters(3)
	if button3_press_count == 1:
		infotitle.text = "[img]res://assets/ui/upgrades/speed_multiplier.png[/img] Quicker Attacks"
		infofirst.text = "-0.05 Second"
		infodesc.text = "Decrease your projectile timeout; it affects how quickly your tower attacks."
		infocost.text = make_cost(100)
	elif button3_press_count == 2:
		if GlobalState.check_gold(100):
			GlobalState.increase_speed_multiplier()
			GlobalState.remove_gold(100)
		button3_press_count = 1
	infosecond.text = "Cur: " + str(GlobalState.tower.get_node("Timer").wait_time) + "s"

#Increase Reach Button
func _on_Button4_pressed():
	button4_press_count += 1
	reset_other_counters(4)
	if button4_press_count == 1:
		infotitle.text = "[img]res://assets/ui/upgrades/reach_multiplier.png[/img] Increase Reach"
		infofirst.text = "+10 Radius"
		infodesc.text = "Decrease your projectile timeout; it affects how quickly your tower attacks."
		infocost.text = make_cost(100)
	elif button4_press_count == 2:
		if GlobalState.check_gold(100):
			GlobalState.increase_reach_multiplier()
			GlobalState.remove_gold(100)
		button4_press_count = 1
	infosecond.text = "Cur: " + str(round(GlobalState.tower.get_node("Area2D").get_node("CollisionShape2D").shape.radius))

func _on_Button5_pressed():
	button5_press_count += 1
	reset_other_counters(5)
	if button5_press_count == 1:
		var texture = load("res://assets/projectiles/"+GlobalState.second_weapon+".png")
		button5.get_node("TextureRect").texture = texture
		infotitle.text = "[img]res://assets/projectiles/"+GlobalState.second_weapon+".png" + "[/img] Next Weapon"
		infofirst.text = "Cur: " + str(GlobalState['weapons'][GlobalState.current_weapon]['damage']) + " dmg"
		infodesc.text = "Unlock your next weapon and deal more damage."
		infocost.text = make_cost(250)
	elif button5_press_count == 2:
		if GlobalState.check_gold(250):
			GlobalState.next_weapon()
			print(GlobalState.current_weapon)
			GlobalState.remove_gold(250)
		button5_press_count = 1
	infosecond.text = "Next: " + str(GlobalState['weapons'][GlobalState.second_weapon]['damage']) + " dmg"
