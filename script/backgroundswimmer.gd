extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	velocity.x = 250
	if randi_range(0,1) == 0:
		animated_sprite_2d.play("blue")
	else:
		animated_sprite_2d.play("green")
	

func _process(delta):
	if position.x > 1000:
		position.x = -600 - randi_range(0,300)
		if randi_range(0,1) == 0:
			animated_sprite_2d.play("blue")
		else:
			animated_sprite_2d.play("green")
			
func _physics_process(delta):
	move_and_slide()
