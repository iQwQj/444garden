extends Control

# References to the joystick parts
@onready var background = $Background
@onready var handle = $Handle

var touch_index = -1
var touch_active = false
var max_distance = 120  # Mobile-friendly touch distance
var dead_zone = 10
var joy_vector = Vector2.ZERO
var initial_touch_pos = Vector2.ZERO

func _ready():
	# Start invisible
	modulate.a = 0  # Completely invisible until touched
	
	# Make sure alpha is properly set when visible
	background.modulate.a = 0.4  # Subtle background
	handle.modulate.a = 0.7      # More visible handle

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			# New touch started anywhere on screen
			if touch_index == -1:
				initial_touch_pos = event.position
				touch_index = event.index
				touch_active = true
				
				# Show joystick at touch position
				position = initial_touch_pos - background.size/2  # Center background at touch
				modulate.a = 1  # Make visible with animation
				handle.position = background.size/2  # Center handle in background
				joy_vector = Vector2.ZERO
				
		elif touch_index == event.index:
			# Our touch has ended
			touch_index = -1
			touch_active = false
			modulate.a = 0  # Hide with animation
			joy_vector = Vector2.ZERO
			
	elif event is InputEventScreenDrag and touch_index == event.index:
		# Calculate drag relative to joystick center
		var touch_pos = event.position - (position + background.size/2)
		handle_input(touch_pos)

func handle_input(touch_pos):
	# Calculate joystick position and vector
	var joy_direction = touch_pos.normalized()
	var joy_distance = touch_pos.length()
	
	# Limit distance to max_distance
	if joy_distance > max_distance:
		joy_distance = max_distance
		
	# Set handle position relative to center
	handle.position = background.size/2 + (joy_direction * joy_distance)
	
	# Calculate output vector with normalized direction and distance-based magnitude
	if joy_distance > dead_zone:
		joy_vector = joy_direction * ((joy_distance - dead_zone) / (max_distance - dead_zone))
	else:
		joy_vector = Vector2.ZERO
		
func get_output():
	return joy_vector
