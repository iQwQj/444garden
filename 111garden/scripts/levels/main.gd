class_name Main
extends Node2D

@onready var player = $Player
@onready var joystick = $UI/Joystick

func _ready():
	# Connect joystick signals to player
	joystick.connect("joystick_moved", Callable(player, "set_joystick_vector"))
	joystick.connect("joystick_released", Callable(player, "set_joystick_vector").bind(Vector2.ZERO))
