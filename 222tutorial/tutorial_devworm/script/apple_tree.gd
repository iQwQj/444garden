extends Node2D

var state = "no apples" # there are 2 states, no apples, apples
var player_in_area = false # check if player is able to pick apple

func _ready() -> void:
	if state == "no apples":
		$growth_timer.start()
		
func _process(delta):
	if state == "no apples":
		$AnimatedSprite2D.play("no_apples")
	if state == "apples":
		$AnimatedSprite2D.play("apples")
		if player_in_area == true:
			if Input.is_action_just_pressed("e"):
				state = "no apples"
				$growth_timer.start()


func _on_pickable_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		# recall that in player.gd there is a "player" function
		# this checks so that only player would trigger apple pickable
		player_in_area = true

func _on_pickable_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
		


func _on_growth_timer_timeout() -> void:
	if state == "no apples":
		state = "apples"
