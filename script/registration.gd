extends Node2D

@onready var parent = $".."
@onready var line_edit = $LineEdit

signal victory

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("CONFIRM"):
		parent.note_name(line_edit.text)
		parent.next_level()
