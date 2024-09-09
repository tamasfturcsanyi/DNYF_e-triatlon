extends CanvasLayer

@onready var time_label = $Control/time_label
@onready var name_label = $Control/name_label



func set_time(time):
	var seconds = time
	while seconds > 60:
		seconds -= 60
	
	var minutes = time / 60
	if minutes < 1 :
		time_label.text = str(seconds).pad_decimals(2)
	else:
		
		time_label.text = str(int(minutes)) + ":" + str(seconds).pad_decimals(2)

func set_player_name(player_name):
	name_label.text = player_name

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_titles():
	time_label.visible = true
	name_label.visible = true

func hide_titles():
	time_label.visible = false
	name_label.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
