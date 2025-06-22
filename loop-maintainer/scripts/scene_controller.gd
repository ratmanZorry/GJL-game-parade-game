extends Node

var main_menu = preload("res://scenes/main_menu.tscn")
var house = preload("res://scenes/house.tscn")
var credits = preload("res://scenes/credits.tscn")

func go_to_main_menu():
	get_tree().change_scene_to_packed(main_menu)

func go_to_house():
	get_tree().change_scene_to_packed(house)

func go_to_credits():
	get_tree().change_scene_to_packed(credits)
