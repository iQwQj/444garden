extends CharacterBody2D

var speed = 100 # used to calculate movement

var player_state # to store player movement status

@export var inv:Inv

var bow_equiped = false # can be set to true for testing purposes
var bow_cooldown = true # so there will be time between arrow firing
var arrow = preload("res://scene/arrow.tscn")

func _physics_process(delta: float):
	# set movement controls in "Project Setting > InputMap"
	var direction = Input.get_vector("left", "right", "up", "down")
	
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle" # used for playing idle animation
	
	elif direction.x != 0 or direction.y !=0:
		player_state = "walking"
		
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("q"):
		if bow_equiped:
			bow_equiped = false
		else:
			bow_equiped = true
	
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	
	if Input.is_action_just_pressed("left_mouse") and bow_equiped and bow_cooldown:
		bow_cooldown = false
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation
		arrow_instance.global_position = $Marker2D.global_position
		add_child(arrow_instance)
		
		await get_tree().create_timer(0.4).timeout # add some cooling time between firing
		bow_cooldown = true # the bow reloads
	
	# take movement direction as input, play according animations
	play_animation(direction) 
	
func play_animation(dir): # "dir" here = direction
	
	# for debug console
	# print(dir)
	
	if player_state == "idle":
		$AnimatedSprite2D.play("idle")
	if player_state == "walking":
		
		# Basic 4-direction movements
		if dir.y == -1:
			$AnimatedSprite2D.play("n_walk")
		if dir.y == 1:
			$AnimatedSprite2D.play("s_walk")
		if dir.x == -1:
			$AnimatedSprite2D.play("w_walk")
		if dir.x == 1:
			$AnimatedSprite2D.play("e_walk")
		
		# diagonal movements
		if dir.x > 0.5 and dir.y < -.05:
			$AnimatedSprite2D.play("ne_walk")
		if dir.x > 0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("se_walk")
		if dir.x < -0.5 and dir.y < -0.5:
			$AnimatedSprite2D.play("nw_walk")
		if dir.x < -0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("sw_walk")
			
func player(): # for later use
	pass
		
func collect(item):
	inv.insert(item)
	
