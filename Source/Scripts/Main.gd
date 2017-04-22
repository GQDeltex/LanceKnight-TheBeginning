extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var time_before = 0
var time = 15
var needed_points = 5
var enemy
var s

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	enemy = preload("res://Scenes/Enemy.tscn")
	set_process(true)
	get_node("ProgressBar").set_max(global.get("max_lifes"))

func _process(delta):
	if (Input.is_action_pressed("toggle_fullscreen")):
		OS.set_window_fullscreen(not OS.is_window_fullscreen())
	if (Input.is_action_pressed("quit")):
		get_tree().change_scene("res://Scenes/Main_Menu.tscn")
	_show_lifes()
	time = time + delta
	if (global.get("points") >= needed_points):
		global.Level += 1
		global.lifes = global.get("max_lifes")
		needed_points += 5*global.get("Level")
	#print (time - time_before)
	get_node("Level").set_text("Level: " + str(global.get("Level")))
	get_node("Points").set_text("Points: " + str(global.get("points")) + "/" + str(needed_points))
	if ((time-time_before) > (20/global.get("Level"))):
		s = enemy.instance()
		global.s_list.append(s)
		print ("Spawned Enemy: " + str(s))
		randomize()
		s.set_pos(Vector2(rand_range(0, 200), rand_range(0,400)))
		add_child(s)
		time_before = 0
		time = 0

func _show_lifes():
	var lifes
	lifes = global.get("lifes")
	get_node("ProgressBar/Label").set_text("Lifes: " + str(global.get("lifes")) + "/" + str(global.get("max_lifes")) + " :")
	get_node("ProgressBar").set_value(lifes)