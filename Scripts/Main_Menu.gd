extends Node2D

# class member variables go here, for example:
# var a = 2
var start_button
var tut_button
var exit_button
var back_button
var welcome_label

func _ready():
	start_button = get_node("Container/Button")
	tut_button = get_node("Container/Button1")
	exit_button = get_node("Container/Button2")
	back_button = get_node("Container 2/Button")
	set_process(true)

func _process(delta):
	if (start_button.is_pressed()):
		get_node("Container").hide()
		get_node("Container 3").show()
		get_tree().change_scene("res://Scenes/Main.tscn")
	if (tut_button.is_pressed()):
		get_node("Container").hide()
		get_node("Container 2").show()
	if (back_button.is_pressed()):
		get_node("Container").show()
		get_node("Container 2").hide()
	if (exit_button.is_pressed()):
		get_tree().quit()