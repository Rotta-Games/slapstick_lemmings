extends Node2D
@onready var movie_screen_animation: AnimatedSprite2D = $Screen/Animation
@onready var Global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	movie_screen_animation.sprite_frames = Global.movie_animation_sprites
	print(movie_screen_animation.sprite_frames.get_frame_count("movie"))
	movie_screen_animation.play("movie")
	breakpoint
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
