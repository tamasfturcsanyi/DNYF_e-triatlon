extends Node

@onready var parent = $".."

const line1 = -25
const line2 = 100
const line3 = 250

const frekv = 300

var stopWatch = 0.0

	# Declare a variable to hold the obstacle scene resource
var PickupScene: PackedScene
var ObstacleScene: PackedScene

var numberOfPickups = 50
var bootle = 0


# Load the obstacle scene
func _ready():
	PickupScene = preload("res://scenes/swimming/pickup.tscn")
	ObstacleScene = preload("res://scenes/swimming/obstacle.tscn")
	spawn_pickups()

# Function to spawn obstacles
func spawn_pickups():
	# Define the possible Y coordinate values
	var possible_y_positions = [line1, line2, line3]
	
	var random = RandomNumberGenerator.new()
	random.randomize()
	
	for i in range(numberOfPickups):  # Adjust the range to spawn the desired number of obstacles
		var coinflip = random.randi() % 2
		var pickup_instance
		if coinflip == 0 && bootle < numberOfPickups/2:
			pickup_instance = PickupScene.instantiate()  # Create an instance of the obstacle scene
			++bootle 
		else:
			pickup_instance = ObstacleScene.instantiate()  # Create an instance of the obstacle scene
		
		add_child(pickup_instance)  # Add the obstacle instance to the scene tree
		
		var random_value = possible_y_positions[random.randi_range(0,2)]
		# Position the obstacle. Adjust as necessary.
		pickup_instance.position = Vector2(i * frekv,random_value)  # Example positioning logic
		print(random_value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"swimmer".global_position.x > 14000:
		stopWatch += delta
		print(parent.get_path())
		parent.next_level()
	
	#$"../../CanvasLayer/Control".update_label(stopWatch)
