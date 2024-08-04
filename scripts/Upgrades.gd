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

func _on_Button1_pressed():
	button1_press_count += 1
	reset_other_counters(1)
	if button1_press_count == 1:
		infotitle.text = "test"
	elif button1_press_count == 2:
		infotitle.text = "button1 was pressed"
		button1_press_count = 0

func _on_Button2_pressed():
	button2_press_count += 1
	reset_other_counters(2)
	if button2_press_count == 1:
		infotitle.text = "test2"
	elif button2_press_count == 2:
		infotitle.text = "button2 was pressed"
		button2_press_count = 0

func _on_Button3_pressed():
	button3_press_count += 1
	reset_other_counters(3)
	if button3_press_count == 1:
		infotitle.text = "test3"
	elif button3_press_count == 2:
		infotitle.text = "button3 was pressed"
		button3_press_count = 0

func _on_Button4_pressed():
	button4_press_count += 1
	reset_other_counters(4)
	if button4_press_count == 1:
		infotitle.text = "test4"
	elif button4_press_count == 2:
		infotitle.text = "button4 was pressed"
		button4_press_count = 0

func _on_Button5_pressed():
	button5_press_count += 1
	reset_other_counters(5)
	if button5_press_count == 1:
		infotitle.text = "test5"
	elif button5_press_count == 2:
		infotitle.text = "button5 was pressed"
		button5_press_count = 0
