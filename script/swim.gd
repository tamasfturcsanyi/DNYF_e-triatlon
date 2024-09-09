extends CharacterBody2D


const SPEEDX = 300.0
const SPEEDY = 1000.0
const ACCLERATIONY = 1000
const ACCLERATIONX = 50

const boostValue = 100
const switchCost = 20


var line = 2

var direction = 0
@onready var collisionShape = $CollisionShape2D
@onready var water = $GPUParticles2D


func boost():
	velocity.x += boostValue
	
func nerf():
	velocity.x -= boostValue
	if velocity.x < 0:
		velocity.x = 0



func _input(event):
	if event.is_action_pressed("DOWN") && line != 3:
		direction = 1
		velocity.x -= switchCost
	
	if event.is_action_pressed("UP") && line != 1:
		direction = -1
		velocity.x -= switchCost
	
	

func _physics_process(delta):
	velocity.x = move_toward(velocity.x,SPEEDX,delta * ACCLERATIONX)
	velocity.y = move_toward(velocity.y,direction * SPEEDY,delta * ACCLERATIONY)
	
	water.update_emmision(velocity.x)
	
	if collisionShape.global_position.y > %gameManager.line2 && line == 1:
		velocity.y = 0 
		line = 2
		direction = 0
	
	if collisionShape.global_position.y < %gameManager.line2 && line == 3:
		velocity.y = 0 
		line = 2
		direction = 0
	
	if collisionShape.global_position.y < %gameManager.line1:
		velocity.y = 0 
		line = 1
		direction = 0
		collisionShape.global_position.y = %gameManager.line1
	
	if collisionShape.global_position.y > %gameManager.line3:
		velocity.y = 0 
		line = 3
		direction = 0
		collisionShape.global_position.y = %gameManager.line3
	
	move_and_slide()
