extends Node2D

var state = "no apples" # there are 2 states, no apples, apples
var player_in_area = false # check if player is able to pick apple

var apple = preload("res://scene/apple_collectable.tscn")

@export var item: InvItem
var player = null

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
				drop_apple()


func _on_pickable_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		# recall that in player.gd there is a "player" function
		# this checks so that only player would trigger apple pickable
		player_in_area = true
		player = body
		
func _on_pickable_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
		


func _on_growth_timer_timeout() -> void:
	if state == "no apples":
		state = "apples"

func drop_apple():
	var apple_instance = apple.instantiate()
	apple_instance.global_position = $Marker2D.global_position
	get_parent().add_child(apple_instance)
	
	
	# this is added after inventory slots for collection is ready
	player.collect(item) # remember to declare var player first
	
	await get_tree().create_timer(3).timeout
	$growth_timer.start()
	
