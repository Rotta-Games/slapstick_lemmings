extends Node

@onready var cameraNode: Camera2D = get_node("MovieCamera")
@onready var timer: Timer = get_node("Timer")
@onready var Global = get_node("/root/Global")

var player: Node2D
var video: VideoStream
var is_recording = true
var video_frames = []


func _ready():
	if get_tree().get_root().has_node("Node2D/Player"):
		player = get_tree().get_root().get_node("Node2D/Player")
		
	Global.movie_animation_sprites.add_animation("movie")



func _process(delta):
	if player:
		cameraNode.global_position = player.get_position_lol()
		
		if is_recording:
			var img = get_viewport().get_texture().get_image()
			var frame = img.save_jpg_to_buffer()
			video_frames.append(frame)
	
	
func save_video() -> void:
	if video_frames.size() == 0:
		print("No frames to save.")
		return

	var frame_size : Vector2 = Vector2()  # Assuming all frames have the same size
	var frame : Image = Image.new()

	# Get the size of the first frame
	frame.load_jpg_from_buffer(video_frames[0])
	frame_size = frame.get_size()

	for frame_data in video_frames:
		frame.load_jpg_from_buffer(frame_data)
		var frame_texture = ImageTexture.new()
		frame_texture.create_from_image(frame)
		Global.movie_animation_sprites.add_frame("movie", frame_texture, 1, -1)

func _on_timer_timeout():
	print("VALMIS")
	cameraNode.zoom = Vector2(1, 1)
	is_recording = false
	save_video()
	get_tree().change_scene_to_file("res://scenes/theater.tscn")

