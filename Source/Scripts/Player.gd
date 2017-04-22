extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var MOTION_SPEED = 140
export var RUNNING_SPEED = 280
export var IDLE_SPEED = 10

var motion = Vector2()
var sprite
var lanze
var speed = 0
var time_before = 0
var time = 0
var metal_sounds = ["Metal_01", "Metal_02", "Metal_03", "Metal_04", "Metal_05", "Metal_06"]

func _ready():
	global.PLAYER = self
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	sprite = get_node("Sprite")
	lanze = get_node("Sprite/Lanze")
	get_node("SamplePlayer2D").set_polyphony(10)

func _get_nearest_enemy():
	var distance = 0
	var attackable
	for enemy in global.get("s_list"):
		if (enemy):
			distance = enemy.get_global_pos().distance_to(get_global_pos())
			if (distance < 150):
				return enemy
	

func _process(delta):
	time += delta
	motion = Vector2(0,0)
	if (Input.is_action_pressed("player_speed")):
		MOTION_SPEED = RUNNING_SPEED
	else:
		MOTION_SPEED = 140
	if (Input.is_action_pressed("player_up")):
		motion += Vector2(0, -1)
		sprite.set_rotd(0)
	if (Input.is_action_pressed("player_down")):
		motion += Vector2(0, 1)
		sprite.set_rotd(180)
	if (Input.is_action_pressed("player_right")):
		motion += Vector2(1, 0)
		sprite.set_rotd(270)
	if (Input.is_action_pressed("player_left")):
		motion += Vector2(-1, 0)
		sprite.set_rotd(90)
	if (Input.is_action_pressed("player_fight")):
		lanze.play("Stab")
		var hithim
		hithim = _get_nearest_enemy()
		if (hithim):
			if ((time - time_before) > 0.5):
				randomize()
				get_node("SamplePlayer2D").play(metal_sounds[int(rand_range(1, 6))])
				hithim.lifes -= 10
				time_before = time
	else:
		lanze.play("IDLE")
	motion = motion.normalized() * MOTION_SPEED * delta
	if (is_colliding()):
		print ("I'm colliding and maybe slidin'")
		var n = get_collision_normal()
		motion = n.slide(motion)
		move(motion)
	else:
		move(motion)
	#print (time - time_before)
	
	if (motion.length() > RUNNING_SPEED * delta):
		sprite.play("RUN")
		if (not get_node("SamplePlayer2D").is_voice_active(0)):
			get_node("SamplePlayer2D").play("Original_Ferdi_Run", 0)
	elif (motion.length() > IDLE_SPEED * delta):
		sprite.play("WALK")
		if (not get_node("SamplePlayer2D").is_voice_active(0)):
			get_node("SamplePlayer2D").play("Original_Ferdi_Run", 0)
	else:
		sprite.play("IDLE")
	if (global.get("lifes") <= 0):
		print ("I died! OMG!!!!")
		get_tree().change_scene("res://Scenes/Main_Menu.tscn")