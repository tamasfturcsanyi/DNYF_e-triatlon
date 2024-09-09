extends CharacterBody2D

const SPEED = 400
const BOOSTAMOUNT = 30
const FRICTION = 100

const DESTINATION = 14000

var nextButton = 1

signal victory

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = 0

@onready var helper = $helper
@onready var sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x > DESTINATION:
		emit_signal("victory")
	
	
func _physics_process(delta):
	if velocity.x > 100:
		velocity.x = move_toward(velocity.x,0,FRICTION * delta )
	if velocity.x > SPEED:
		velocity.x -= FRICTION * delta
	move_and_slide()

func _input(event):
	if event.is_action_pressed("RIGHT"):
		if nextButton == 3 :
			velocity.x += BOOSTAMOUNT
			nextButton = 4
			sprite.play("4")
			helper.play("4")
		else:
			velocity.x -= BOOSTAMOUNT
	
	if event.is_action_pressed("DOWN"):
		if nextButton == 4 :
			velocity.x += BOOSTAMOUNT
			sprite.play("3")
			helper.play("1")
			nextButton = 1
		else:
			velocity.x -= BOOSTAMOUNT
	
	if event.is_action_pressed("LEFT"):
		if nextButton == 1:
			velocity.x += BOOSTAMOUNT
			nextButton = 2
			sprite.play("2")
			helper.play("2")
		else:
			velocity.x -= BOOSTAMOUNT
	
	if event.is_action_pressed("UP"):
		if nextButton == 2 :
			sprite.play("1")
			helper.play("3")
			velocity.x += BOOSTAMOUNT
			nextButton = 3
		else:
			velocity.x -= BOOSTAMOUNT

