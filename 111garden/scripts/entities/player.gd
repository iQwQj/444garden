extends CharacterBody2D

@export var speed = 150  # Increased for better map traversal
@onready var animated_sprite = $AnimatedSprite2D
@onready var camera = $Camera2D  # Reference to the camera

# Camera configuration
@export var camera_smoothing_enabled = true
@export var camera_smoothing_speed = 5.0
@export var camera_zoom = Vector2(0.7, 0.7)  # Adjust based on your map size

# Get the joystick from the scene tree
#var last_direction = Vector2.ZERO
#var is_moving = false
var joystick

func _ready():
	# Find the joystick node - might need to adjust path based on your scene structure
	joystick = get_node("/root/Main/UI/Joystick")
	if not joystick:
		print("Warning: Joystick not found!")
	# Configure camera
	if camera:
		camera.enabled = true
		camera.position_smoothing_enabled = camera_smoothing_enabled
		camera.position_smoothing_speed = camera_smoothing_speed
		camera.zoom = camera_zoom
		# Set camera limits based on your TileMap size (update these values)
		# camera.limit_left = 0
		# camera.limit_top = 0
		# camera.limit_right = 3000  # Your map width
		# camera.limit_bottom = 3000  # Your map height

func _physics_process(delta):
	# Get joystick input if available
	var direction = Vector2.ZERO
	#var input_detected = false
	
	if joystick:
		direction = joystick.get_output()
	
	# Also support keyboard input for testing on desktop
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	
	# Normalize to prevent diagonal movement being faster
	if direction.length() > 1:
		direction = direction.normalized()
	
	# If input is detected, update movement and remember we're moving
	velocity = direction * speed

	move_and_slide()
	
	# Update animation - use last_direction to keep facing the right way
	update_animation(direction)

func	 update_animation(direction):
	if direction.length() == 0:
		# Idle animation - use static image
		if animated_sprite.animation != "idle":
			animated_sprite.play("idle")
	else:
		# Walking animation - alternate between left/right leg images
		
		# Determine primary direction (horizontal or vertical)
		if abs(direction.x) > abs(direction.y):
			# Horizontal movement
			if direction.x > 0:
				# Moving right
				animated_sprite.play("walk_right")
				animated_sprite.flip_h = false
			else:
				# Moving left - use same animation but flipped
				animated_sprite.play("walk_right")
				animated_sprite.flip_h = true
		else:
			# Vertical movement
			if direction.y > 0:
				# Moving down
				animated_sprite.play("walk_down")
				animated_sprite.flip_h = false
			else:
				# Moving up
				animated_sprite.play("walk_up")
				animated_sprite.flip_h = false
