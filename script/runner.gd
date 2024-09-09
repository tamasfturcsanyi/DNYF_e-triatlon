extends CharacterBody2D

const SPEED = 500
const BOOSTAMOUNT = 30
const FRICTION = 100
const DESTINATION = 14000

signal victory

var nextButton = 1
var timer = 6

var random = RandomNumberGenerator.new()

@onready var helper = $helper
@onready var runner = $runner


# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()
	velocity.x = 0
	timer = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if !runner.is_playing():
		if velocity.x < 100:
			runner.play("slow")
		elif velocity.x < 200:
			runner.play("mid")
		else:
			runner.play("fast")
	
	if timer > 3:
		timer = 0
		nextButton = random.randi() % 4
		nextButton += 1
		helper.play(str(nextButton))
	
	if position.x > DESTINATION:
		emit_signal("victory")


func _physics_process(delta):
	velocity.x = move_toward(velocity.x,0,FRICTION * delta )
	if velocity.x > SPEED:
		velocity.x -= FRICTION * delta
	move_and_slide()

func _input(event):
	if event.is_action_pressed("RIGHT"):
		if nextButton == 3 :
			velocity.x += BOOSTAMOUNT
		else:
			velocity.x -= BOOSTAMOUNT
	
	if event.is_action_pressed("DOWN"):
		if nextButton == 4 :
			velocity.x += BOOSTAMOUNT
		else:
			velocity.x -= BOOSTAMOUNT
	
	if event.is_action_pressed("LEFT"):
		if nextButton == 1 :
			velocity.x += BOOSTAMOUNT
		else:
			velocity.x -= BOOSTAMOUNT
	
	if event.is_action_pressed("UP"):
		if nextButton == 2 :
			velocity.x += BOOSTAMOUNT
		else:
			velocity.x -= BOOSTAMOUNT
