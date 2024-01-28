extends Node2D

@onready var laugh1 = $LaughAudio1
@onready var laugh2 = $LaughAudio2
@onready var laugh3 = $LaughAudio3
@onready var laugh4 = $LaughAudio4

var laughs = []
const LAUGH_THRESHOLD = 50

var last_frame_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	laughs = [laugh1, laugh2, laugh3, laugh4]
	_play_random_laugh()

func _play_random_laugh():
		var rand_index = randi() % laughs.size()
		laughs[rand_index].play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Global.score - last_frame_score) > LAUGH_THRESHOLD:
		_play_random_laugh()
	last_frame_score = Global.score
