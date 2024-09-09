extends Node2D

@onready var parent = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _input(event):
	if event.is_action_pressed("ACTION") :
		parent.next_level()
	if event.is_action_pressed("DOWN"):
		parent.watch_leaderboard()
