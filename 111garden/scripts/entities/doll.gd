# npc.gd
extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D  # Adjust based on your node structure
@onready var collision_shape = $CollisionShape2D
@onready var detection_area = $DetectionArea
@onready var timer = $Timer

# Configuration
@export var fade_duration = 1.0  # Time in seconds for disappearing animation
@export var hidden_duration = 3.0  # seconds
@export var detection_radius = 64.0  # Adjust based on your NPC size

var player_in_range = false
var is_hidden = false
var is_fading = false
var fade_progress = 0.0
var original_modulate

func _ready():
	# Store original color/transparency
	original_modulate = sprite.modulate
	
	# Setup detection area
	var detection_shape = CircleShape2D.new()
	detection_shape.radius = detection_radius
	detection_area.get_node("CollisionShape2D").shape = detection_shape
	
	# Connect signals
	detection_area.connect("body_entered", _on_detection_area_body_entered)
	detection_area.connect("body_exited", _on_detection_area_body_exited)
	timer.connect("timeout", _on_timer_timeout)
	
	# Set timer wait time
	timer.wait_time = hidden_duration
	timer.one_shot = true

func _process(delta):
	if is_fading:
		# Update fade animation
		fade_progress += delta / fade_duration
		if fade_progress >= 1.0:
			fade_progress = 1.0
			is_fading = false
			is_hidden = true
			sprite.visible = false
			collision_shape.disabled = true  # Disable collision while hidden
			timer.start()  # Start the hidden duration timer
		else:
			# Gradually fade out
			sprite.modulate.a = original_modulate.a * (1.0 - fade_progress)

func _on_detection_area_body_entered(body):
	if body.is_in_group("player") and !is_hidden and !is_fading:
		player_in_range = true
		start_fade_out()

func _on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false

func _on_timer_timeout():
	# Timer finished, can reappear if player not in range
	if !player_in_range:
		reappear()

func start_fade_out():
	is_fading = true
	fade_progress = 0.0

func reappear():
	is_hidden = false
	is_fading = false
	sprite.modulate = original_modulate
	sprite.visible = true
	collision_shape.disabled = false  # Re-enable collision
