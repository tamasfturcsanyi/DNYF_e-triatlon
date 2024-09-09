extends Node

var levels = {
	"menu": 		"res://scenes/MENU.tscn",
	"registration": "res://scenes/registration.tscn",
	"swim": 		"res://scenes/swimming/swim.tscn",
	"takeOn":		"res://scenes/takeOn/take_on.tscn",
	"cycle": 		"res://scenes/cycling/cycle.tscn",
	"run":			"res://scenes/running/run.tscn",
	"victory":		"res://scenes/victory.tscn"
}

var current_player_name = "PLAYER"
var current_player_time = 0

@onready var hud = $HUD
@onready var full = $full
@onready var back = $back


var current_level = null
var current_level_name = ""
var racing = false


# Called when the node enters the scene tree for the first time.
func _ready():
	load_level("menu")
	hud.hide()
	full.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if racing:
		current_player_time += delta
		hud.set_time(current_player_time)
		if !back.playing:
			back.play()
	else:
		if !full.playing:
			full.play()
	

func load_level(level_name):
	current_level_name = level_name
	if current_level != null:
		current_level.queue_free()
		
	var level_path = levels[level_name]
	if level_path == null:
		print("level not found" + level_name)
		return
	
	var level_scene = load(level_path)
	current_level = level_scene.instantiate()
	add_child(current_level)
	if current_level_name == "victory"&& current_player_time != 0:
		tabella()

# Function to transition to the next level
func next_level():
	if current_level != null:
		var next_level_name = get_next_level_name()
		load_level(next_level_name)
		if next_level_name == "swim":
			racing = true
			hud.show()
			full.stop()
		if next_level_name == "menu" || next_level_name == "victory":
			racing = false
			hud.hide() 
			full.play()
			back.stop()

# Helper function to determine the next level
func get_next_level_name():
	match current_level_name:
		"menu":
			return "registration"
		"registration":
			return "swim"
		"swim":
			return "takeOn"
		"takeOn":
			return "cycle"
		"cycle":
			return "run"
		"run":
			racing = false
			return "victory"
		"victory":
			return "menu"
		_:
			print("default" + current_level_name)
			return "menu"

func note_name(player_name):
	current_player_name = player_name
	hud.set_player_name(current_player_name)
	
func watch_leaderboard():
	load_level("victory")

func tabella():
	if current_player_time != 0:
		current_level.add_record(current_player_name,current_player_time)
		current_level.show_yourtime()
		current_player_time = 0
	#current_level.update_tabella()
	
