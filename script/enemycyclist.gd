extends CharacterBody2D

var SPEED = randi_range(100,300)
const FRICTION = 100

@export var menu = false
@export var runner = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var coinflip = randi_range(0,1)
	
		
	velocity.x = 0
	if !runner:
		if coinflip == 0:
			sprite.play("blue")
		else:
			sprite.play("yellow")
	else:
		if coinflip == 0:
			sprite.play("runner_blue")
		else:
			sprite.play("runner_green")
	

@onready var sprite = $AnimatedSprite2D
# Called every frame. 'delta' is the elapsed time since the previous frame.

	
func _physics_process(delta):
	velocity.x = move_toward(velocity.x,SPEED,FRICTION * delta )
	if menu:
		if position.x > 1000:
			position.x = -600 - randi_range(0,300)
			if randi_range(0,1) == 0:
				if randi_range(0,1) == 0:
					sprite.play("blue")
				else:
					sprite.play("yellow")
			else:
				if randi_range(0,1) == 0:
					sprite.play("runner_blue")
				else:
					sprite.play("runner_green")
	move_and_slide()

