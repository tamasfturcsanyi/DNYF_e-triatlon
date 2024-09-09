extends Node

# File path to store the leaderboard data
const FILE_PATH = "C://Users//Tomi//Desktop//leaderboard.txt"

# Array to hold the leaderboard data
var leaderboard = []
var num_of_entries = 0


# Load the leaderboard from the file
func _ready():
	#print("kutya")
	#load_leaderboard()
	#add_score("Agoston", 84)
	#add_score("adam", 14)
	#add_score("Flori", 81)
	#add_score("Tomi", 44)
	#add_score("Tomi", 42)
	#update_leaderboard("Tomi",41)
	#update_leaderboard("Janos",39)
	#update_leaderboard("Flori",37)
	#update_leaderboard("Tomi",35)
	pass
	#print(leaderboard)

# Save the leaderboard to the file
func save_leaderboard():
	var config = ConfigFile.new()
	config.set_value("leaderboard", "scores", leaderboard)
	var err = config.save(FILE_PATH)
	if err != OK:
		print("Error saving leaderboard: ", err)

# Load the leaderboard from the file
func load_leaderboard():
	var config = ConfigFile.new()
	var err = config.load(FILE_PATH)
	if err == OK:
		leaderboard = config.get_value("leaderboard", "scores", [])
	else:
		print("Error loading leaderboard: ", err)
		leaderboard = []

# Add a new score to the leaderboard
#func add_score(name: String, time: float):
	#num_of_entries += 1
	#leaderboard.append({"name": name, "time": time})
	##leaderboard.sort_custom(compare_scores)  # Sort the leaderboard
	#save_leaderboard()

# Compare function for sorting scores
func compare_scores(a, b):
	if a["time"] < b["time"]:
		return true
	else:
		return false

# Get the top N scores from the leaderboard
func get_top_scores(n: int):
	return leaderboard.slice(0, n)

func add_score(name: String, time: float):
		# Remove duplicates and keep only the shortest time for the same name
	 
		# Add the new score
	leaderboard.append({"name": name, "time": time})
	   
		# Sort the leaderboard
	leaderboard.sort_custom(compare_scores)
		
		# Save the leaderboard
	#remove_duplicates(name)
	
	save_leaderboard()

func clean():
	for record in leaderboard:
		var name = record["name"]
		remove_duplicates(name)
	save_leaderboard()

# Remove duplicates and keep only the shortest time for the same name
func remove_duplicates(name: String):
	var filtered_leaderboard = []
	var min_time = INF
	
		# Find the minimum time for the given name
	for record in leaderboard:
		if record["name"] == name:
			if record["time"] < min_time:
				min_time = record["time"]
	
	# Filter out duplicates keeping only the record with the shortest time
	for record in leaderboard:
		if record["name"] != name or record["time"] == min_time:
			filtered_leaderboard.append(record)
	
	leaderboard = filtered_leaderboard

# Compare function for sorting scores
#func compare_scores(a, b):
	#return a["time"] < b["time"] ? -1 : 1


# Get the record by its placement
func get_record_by_placement(placement: int):
	if placement >= 0 and placement < leaderboard.size():
		return leaderboard[placement]
	else:
		return null  # Return null if the placement is out of bounds

func lets_sort():
	leaderboard.sort_custom(compare_scores)
	save_leaderboard()
