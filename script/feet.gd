extends CharacterBody2D

signal front

@onready var sprite_2d = $Sprite2D


const TEMPO = 2
const penaltyAmount = 1

var accleration = 0

var tried = false
var penalty = 0
var velocityBuffer = 0
var positionBuffer = 0




func _ready():
	velocity.x = 500
	
	

func _physics_process(delta):
	
	
	if !tried:
		
		
		scale = Vector2(1,1)
		accleration = position.x *  -TEMPO
		velocity.x += accleration * delta
		move_and_slide()
	else:
		scale = Vector2(0.8,0.8)
		penalty += delta
		
		if penalty > penaltyAmount:
			emit_signal("front")
			penalty = 0
			tried = false
			velocity.x = velocityBuffer
			position.y = positionBuffer

func _input(event):
	if event.is_action_pressed("UP") && !tried:
		emit_signal("front")
		tried = true
		velocityBuffer = velocity.x
		velocity.x = 0
		positionBuffer = position.y
		position.y -= 200


func rightous():
	sprite_2d.play("right")
