extends Node

@export var active = true
var sound_children = []
var overall_volume = 0
var music_player = null
var music_replay = true

func play_music(music_name, volume = 0, replay = true):
	if !music_player:
		music_player = AudioStreamPlayer.new()
		music_player.connect("finished", self, "playit_back")
		get_tree().add_child(music_player)
	
	if active:
		music_player.stream = load("res://music/" + music_name)
		music_player.volume_db = volume + overall_volume
		music_player.play()
		music_replay = replay

func playit_back():
	if music_replay:
		#yield(get_tree().create_timer(11.0), "timeout")
		music_player.play()

func play_sound_from_name(sound_name, pitch_shift = 0.1, volume = 0, uno = false):
	play_sound_from_stream(load("res://sounds/" + sound_name), pitch_shift, volume, uno)

func play_sound_from_stream(stream, pitch_shift = 0.1, volume = 0, uno = false):
	if !active: return
	#for sound in sound_children:
		#if uno and sound.stream == stream and sound.playing and sound.get_playback_position() == 0: return
		#if !sound.playing:
			#setup_sound_and_play(sound, position, stream, pitch_shift, volume)
			#return
	
	var new_sound = AudioStreamPlayer.new()
#	new_sound.max_distance = 2000
	add_child(new_sound)
	setup_sound_and_play(new_sound, stream, pitch_shift, volume)
	sound_children.append(new_sound)

func setup_sound_and_play(sound, stream, pitch_shift, volume):
	sound.stream = stream
	sound.pitch_scale = pitch_shift * randf() + 1
	sound.volume_db = volume + overall_volume
#	print(stream.resource_path)
	sound.play()

func set_overall_volume(new_volume):
	overall_volume = new_volume

func clear_sounds():
	sound_children = []
