extends Node2D

@onready var parent = $".."
@onready var pipa = $pipa
@onready var iksz = $iksz
@onready var feet = $feet
@onready var left = $left
@onready var right = $right
@onready var helper = $feet/helper

const BORDER_LEFT = -15
const BORDER_RIGHT = 15

var done = 0
var got_point = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pipa.play("pipa")
	iksz.play("iksz")
	right.play("right")
	helper.play("2")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if done == 2 && !got_point:
		parent.next_level()
	print(done)
	print(got_point)
	if feet.tried:
		
		if feet.position.x > BORDER_LEFT && feet.position.x < BORDER_RIGHT:
			pipa.visible = true
			if !got_point:
				feet.visible = false
				done += 1
				got_point = true
				if done == 1:
					left.play("left_done")
			
		else:
			iksz.visible = true
	else:
		if got_point:
			feet.visible = true
			right.play("right")
			right.position = Vector2(0,0)
			left.position = Vector2(-300,-100)
			feet.rightous()
		got_point = false
		pipa.visible = false
		iksz.visible = false
	


func _on_feet_victory():
	parent.next_level()


func _on_feet_front():
	pass
