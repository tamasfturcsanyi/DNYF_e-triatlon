extends Node2D

@onready var parent = $".."


@onready var leaderboard = $Leaderboard
@onready var _1 = $"Control/1"
@onready var _2 = $"Control/2"
@onready var _3 = $"Control/3"
@onready var _4 = $"Control/4"
@onready var _5 = $"Control/5"
@onready var _6 = $"Control/6"
@onready var _7 = $"Control/7"
@onready var _8 = $"Control/8"
@onready var _9 = $"Control/9"
@onready var _10 = $"Control/10"
@onready var yourtime = $yourtime
@onready var control = $Control

@onready var score = $yourtime/Score
@onready var score_2 = $yourtime/Score2

var player_name
var player_time

var timer = 0

func update_tabella():
	
	leaderboard.load_leaderboard()
	leaderboard.clean()
	leaderboard.lets_sort()
	
	if leaderboard.get_record_by_placement(0) == null:
		return
	_1.text = "1." + str(leaderboard.get_record_by_placement(0)["name"]) + "       " + str(leaderboard.get_record_by_placement(0)["time"])
	if leaderboard.get_record_by_placement(1) == null:
		return
	_2.text = "2." + str(leaderboard.get_record_by_placement(1)["name"]) + "       " + str(leaderboard.get_record_by_placement(1)["time"])
	if leaderboard.get_record_by_placement(2) == null:
		return
	_3.text = "3." + str(leaderboard.get_record_by_placement(2)["name"]) + "       " + str(leaderboard.get_record_by_placement(2)["time"])
	if leaderboard.get_record_by_placement(3) == null:
		return
	_4.text = "4." + str(leaderboard.get_record_by_placement(3)["name"]) + "       " + str(leaderboard.get_record_by_placement(3)["time"])
	if leaderboard.get_record_by_placement(4) == null:
		return
	_5.text = "5." + str(leaderboard.get_record_by_placement(4)["name"]) + "       " + str(leaderboard.get_record_by_placement(4)["time"])
	if leaderboard.get_record_by_placement(5) == null:
		return
	_6.text = "6." + str(leaderboard.get_record_by_placement(5)["name"]) + "       " + str(leaderboard.get_record_by_placement(5)["time"])
	if leaderboard.get_record_by_placement(6) == null:
		return
	_7.text = "7." + str(leaderboard.get_record_by_placement(6)["name"]) + "       " + str(leaderboard.get_record_by_placement(6)["time"])
	if leaderboard.get_record_by_placement(7) == null:
		return
	_8.text = "8." + str(leaderboard.get_record_by_placement(7)["name"]) + "       " + str(leaderboard.get_record_by_placement(7)["time"])
	if leaderboard.get_record_by_placement(8) == null:
		return
	_9.text = "9." + str(leaderboard.get_record_by_placement(8)["name"]) + "       " + str(leaderboard.get_record_by_placement(8)["time"])
	if leaderboard.get_record_by_placement(9) == null:
		return
	_10.text = "10." + str(leaderboard.get_record_by_placement(9)["name"]) + "       " + str(leaderboard.get_record_by_placement(9)["time"])

# Called when the node enters the scene tree for the first time.
func _ready():
	leaderboard.load_leaderboard()
	parent.tabella()
	update_tabella()
	

func set_label():
	var seconds = player_time
	while seconds > 60:
		seconds -= 60
	
	var minutes = player_time / 60
	if minutes < 1 :
		score_2.text = str(seconds).pad_decimals(2)
	else:
		score_2.text = str(int(minutes)) + ":" + str(seconds).pad_decimals(2)
	score.text = "YOUR TIME:"
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if timer > 5 :
		yourtime.visible = false
		control.visible = true

func add_record(name, time):
	player_name = name
	player_time = time
	leaderboard.add_score(name,time)
	set_label()

func _input(event):
	
	if event.is_action_pressed("ACTION"):
		parent.next_level()
	if event.is_action_pressed("UP"):
		leaderboard.load_leaderboard()
		leaderboard.lets_sort()
		update_tabella()
		
func show_yourtime():
	yourtime.visible = true
	control.visible = false
