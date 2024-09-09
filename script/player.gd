extends CharacterBody2D


const SPEEDX = 250.0
const SPEEDY = 1000.0
const ACCLERATIONY = 1000
const ACCLERATIONX = 50

const boostValue = 100
const switchCost = 10
const MOVER = 20


var line = 2

var direction = 0
@onready var collisionShape = $CollisionShape2D
@onready var water = $GPUParticles2D
@onready var parent = $".."

var changeWill = 0


func boost():
	velocity.x += boostValue
	
func nerf():
	velocity.x -= boostValue
	if velocity.x < 0:
		velocity.x = 0

var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()
	var coinflip = random.randi() % 2
	if coinflip == 0:
		$AnimatedSprite2D.play("blue")
	else:
		$AnimatedSprite2D.play("green")

func move():
	changeWill = 0
	var coinflip = random.randi() % 2
	if coinflip == 0 && line != 3:
		direction = 1
		velocity.x -= switchCost
	
	if coinflip == 1 && line != 1:
		direction = -1
		velocity.x -= switchCost
	
	

func _physics_process(delta):
	changeWill += delta * MOVER
	if(changeWill > random.randi() % 500):
		move()
	velocity.x = move_toward(velocity.x,SPEEDX,delta * ACCLERATIONX)
	velocity.y = move_toward(velocity.y,direction * SPEEDY,delta * ACCLERATIONY)
	
	water.update_emmision(velocity.x)
	
	if collisionShape.global_position.y > parent.line2 && line == 1:
		velocity.y = 0 
		line = 2
		direction = 0
	
	if collisionShape.global_position.y < parent.line2 && line == 3:
		velocity.y = 0 
		line = 2
		direction = 0
	
	if collisionShape.global_position.y < parent.line1:
		velocity.y = 0 
		line = 1
		direction = 0
		collisionShape.global_position.y = parent.line1
	
	if collisionShape.global_position.y > parent.line3:
		velocity.y = 0 
		line = 3
		direction = 0
		collisionShape.global_position.y = parent.line3
	
	move_and_slide()
