# Door.gd - Create this script
extends Area2D

@export var target_scene: String = ""
@export var door_name: String = "door"
@export var door_color: Color = Color.WHITE

func _ready():
	$Label.text = door_name
	$ColorRect.color = door_color

func _on_body_entered(body):
	if body.is_in_group("player") and target_scene != "":
		get_tree().change_scene_to_file(target_scene)
