extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var MOTION_SPEED = 140
var motion = Vector2()
var lifes = 100
var timer = false
var time = 3
var time_before = 0
var time_dir = 0
var area
onready var sprite = get_node("Area2D/AnimatedSprite")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	
func _process(delta):
	var distance
	distance = get_global_pos().distance_to(global.get("PLAYER").get_global_pos())
	#print (distance)
	if (distance < 150):
		timer = true
	else:
		timer = false
	get_node("ProgressBar").set_value(lifes)
	time += delta
	if ((time - time_before) > 2 and timer == true):
		global.lifes = global.get("lifes")-10
		#print (global.get("lifes"))
		time_before = time
	elif ((time - time_before) > 2):
		time_before = time
	#print (lifes)
	if (lifes <= 0):
		global.points += 1
		global.lifes += 20
		print ("Killed Enemy: " + str(self))
		queue_free()
		global.get("s_list").erase(self)
	
	if ((time - time_dir) > 3):
		var dir
		motion = Vector2()
		randomize()
		dir = int(rand_range(0, 4))
		#print (dir)
		time_dir = time
		if (dir == 0):
			motion += Vector2(0, -1)
			sprite.set_rotd(90)
		if (dir == 1):
			motion += Vector2(0, 1)
			sprite.set_rotd(270)
		if (dir == 2):
			motion += Vector2(1, 0)
			sprite.set_rotd(0)
		if (dir == 3):
			motion += Vector2(-1, 0)
			sprite.set_rotd(180)
	motion = motion.normalized() * MOTION_SPEED * delta
	move(motion)
	if (motion.length() > (10*delta)):
		sprite.play("WALK")
	else:
		sprite.play("IDLE")
	if (get_global_pos().x > get_viewport().get_rect().size.x or get_global_pos().x < 0):
		motion.x = -motion.x
		sprite.set_rotd(-sprite.get_rotd())
	if (get_global_pos().y > get_viewport().get_rect().size.y or get_global_pos().y < 0):
		motion.y = -motion.y
		sprite.set_rotd(-sprite.get_rotd())
	